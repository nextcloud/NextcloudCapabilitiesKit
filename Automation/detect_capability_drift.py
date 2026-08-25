#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
# SPDX-License-Identifier: LGPL-3.0-or-later

"""Detect Nextcloud server commits that may alter the capabilities response."""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
import urllib.error
import urllib.parse
import urllib.request
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Any


class CapabilitySyncError(RuntimeError):
    """An expected failure while reading the configured upstream repository."""


@dataclass(frozen=True)
class Upstream:
    repository: str
    branch: str


@dataclass(frozen=True)
class ChangedFile:
    filename: str
    status: str
    previous_filename: str | None


def load_json(path: Path) -> dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except OSError as error:
        raise CapabilitySyncError(f"Could not read {path}: {error}") from error
    except json.JSONDecodeError as error:
        raise CapabilitySyncError(f"Could not parse {path}: {error}") from error

    if not isinstance(value, dict):
        raise CapabilitySyncError(f"{path} must contain a JSON object")

    return value


def load_upstream(manifest: dict[str, Any]) -> Upstream:
    upstream = manifest.get("upstream")
    if not isinstance(upstream, dict):
        raise CapabilitySyncError("The provider manifest must contain an upstream object")

    repository = upstream.get("repository")
    branch = upstream.get("branch")
    if not isinstance(repository, str) or "/" not in repository:
        raise CapabilitySyncError("The upstream repository must be in owner/repository form")
    if not isinstance(branch, str) or not branch:
        raise CapabilitySyncError("The upstream branch must be a non-empty string")

    return Upstream(repository=repository, branch=branch)


def load_revision(state: dict[str, Any], repository: str) -> str:
    upstreams = state.get("upstreams")
    if not isinstance(upstreams, dict):
        raise CapabilitySyncError("The sync state must contain an upstreams object")

    upstream = upstreams.get(repository)
    if not isinstance(upstream, dict):
        raise CapabilitySyncError(f"The sync state has no revision for {repository}")

    revision = upstream.get("revision")
    if not isinstance(revision, str) or not re.fullmatch(r"[0-9a-f]{7,64}", revision):
        raise CapabilitySyncError(f"The revision for {repository} is not a Git commit SHA")

    return revision


def load_blocked_comparison(state: dict[str, Any], repository: str) -> dict[str, str] | None:
    upstreams = state.get("upstreams")
    if not isinstance(upstreams, dict):
        raise CapabilitySyncError("The sync state must contain an upstreams object")

    upstream = upstreams.get(repository)
    if not isinstance(upstream, dict):
        raise CapabilitySyncError(f"The sync state has no revision for {repository}")

    blocked = upstream.get("blockedComparison")
    if blocked is None:
        return None
    if not isinstance(blocked, dict):
        raise CapabilitySyncError(f"The blocked comparison for {repository} must be an object")

    from_revision = blocked.get("fromRevision")
    to_revision = blocked.get("toRevision")
    reason = blocked.get("reason")
    if (
        not isinstance(from_revision, str)
        or not re.fullmatch(r"[0-9a-f]{7,64}", from_revision)
        or not isinstance(to_revision, str)
        or not re.fullmatch(r"[0-9a-f]{7,64}", to_revision)
        or not isinstance(reason, str)
        or not reason
    ):
        raise CapabilitySyncError(f"The blocked comparison for {repository} is invalid")

    return {"fromRevision": from_revision, "toRevision": to_revision, "reason": reason}


def api_request(api_url: str, path: str, token: str | None) -> dict[str, Any]:
    url = f"{api_url.rstrip('/')}/{path.lstrip('/')}"
    headers = {
        "Accept": "application/vnd.github+json",
        "User-Agent": "NextcloudCapabilitiesKit-capability-sync",
        "X-GitHub-Api-Version": "2026-03-10",
    }
    if token:
        headers["Authorization"] = f"Bearer {token}"

    request = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            payload = json.load(response)
    except urllib.error.HTTPError as error:
        detail = error.read().decode("utf-8", errors="replace")
        raise CapabilitySyncError(f"GitHub API request to {path} failed with {error.code}: {detail}") from error
    except urllib.error.URLError as error:
        raise CapabilitySyncError(f"GitHub API request to {path} failed: {error.reason}") from error
    except json.JSONDecodeError as error:
        raise CapabilitySyncError(f"GitHub API request to {path} did not return JSON") from error

    if not isinstance(payload, dict):
        raise CapabilitySyncError(f"GitHub API request to {path} did not return an object")

    return payload


def is_capability_source(path: str, source_paths: dict[str, Any]) -> bool:
    if path in source_paths.get("exact", []):
        return True

    if not path.startswith("apps/"):
        return False

    if "/lib/" in path and any(path.endswith(suffix) for suffix in source_paths.get("providerFileSuffixes", [])):
        return True

    return any(path.endswith(registration_file) for registration_file in source_paths.get("registrationFiles", []))


def capability_files(compare: dict[str, Any], source_paths: dict[str, Any]) -> list[ChangedFile]:
    files = compare.get("files")
    if not isinstance(files, list):
        raise CapabilitySyncError("The GitHub compare response did not contain a files array")
    if len(files) >= 300:
        raise CapabilitySyncError(
            "The GitHub compare response reached its 300-file limit; "
            "advance the sync state before relying on this report"
        )

    matches: list[ChangedFile] = []
    for item in files:
        if not isinstance(item, dict):
            continue

        filename = item.get("filename")
        status = item.get("status")
        previous_filename = item.get("previous_filename")
        if not isinstance(filename, str) or not isinstance(status, str):
            continue
        if previous_filename is not None and not isinstance(previous_filename, str):
            previous_filename = None

        if is_capability_source(filename, source_paths) or (
            previous_filename is not None and is_capability_source(previous_filename, source_paths)
        ):
            matches.append(
                ChangedFile(
                    filename=filename,
                    status=status,
                    previous_filename=previous_filename,
                )
            )

    return matches


def report(
    upstream: Upstream,
    from_revision: str,
    to_revision: str,
    files: list[ChangedFile],
    status: str = "ok",
    blocked_comparison: dict[str, str] | None = None,
) -> dict[str, Any]:
    value: dict[str, Any] = {
        "schemaVersion": 1,
        "status": status,
        "generatedAt": datetime.now(timezone.utc).isoformat(),
        "upstream": {
            "repository": upstream.repository,
            "branch": upstream.branch,
            "fromRevision": from_revision,
            "toRevision": to_revision,
            "compareURL": f"https://github.com/{upstream.repository}/compare/{from_revision}...{to_revision}",
        },
        "hasCapabilitySourceChanges": bool(files),
        "changedFiles": [
            {
                "filename": file.filename,
                "status": file.status,
                "previousFilename": file.previous_filename,
                "url": f"https://github.com/{upstream.repository}/blob/{to_revision}/{file.filename}",
            }
            for file in files
        ],
    }
    if blocked_comparison is not None:
        value["blockedComparison"] = blocked_comparison
    return value


def markdown_report(value: dict[str, Any]) -> str:
    upstream = value["upstream"]
    status = value.get("status", "ok")
    if status == "comparison_too_large":
        return "\n".join(
            [
                "# Nextcloud capability comparison requires manual review",
                "",
                f"Upstream: [`{upstream['repository']}`]({upstream['compareURL']})",
                "",
                f"Compared `{upstream['fromRevision']}` to `{upstream['toRevision']}` on `{upstream['branch']}`.",
                "",
                "GitHub returned its 300-file compare limit. No capability conclusion was made.",
                "Record the blocked comparison in the sync state, then manually partition the range or advance the state.",
                "",
            ]
        )
    if status == "comparison_already_blocked":
        return "\n".join(
            [
                "# Nextcloud capability comparison is already blocked",
                "",
                f"Upstream: [`{upstream['repository']}`]({upstream['compareURL']})",
                "",
                f"The range `{upstream['fromRevision']}` to `{upstream['toRevision']}` was previously marked as oversized.",
                "Manual partitioning or state advancement is required before retrying it.",
                "",
            ]
        )

    lines = [
        "# Nextcloud capability source change",
        "",
        f"Upstream: [`{upstream['repository']}`]({upstream['compareURL']})",
        "",
        f"Compared `{upstream['fromRevision']}` to `{upstream['toRevision']}` on `{upstream['branch']}`.",
        "",
        "## Changed capability sources",
        "",
        "| Status | File |",
        "| --- | --- |",
    ]

    for file in value["changedFiles"]:
        previous = file["previousFilename"]
        name = file["filename"] if previous is None else f"{previous} -> {file['filename']}"
        lines.append(f"| {file['status']} | [`{name}`]({file['url']}) |")

    lines.extend(
        [
            "",
            "This report identifies potential capability-contract changes from provider source files.",
            "Confirm the public JSON response before changing a Swift model.",
            "",
        ]
    )
    return "\n".join(lines)


def write_github_output(path: Path, value: dict[str, Any]) -> None:
    upstream = value["upstream"]
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        "\n".join(
            [
                f"changed={'true' if value['hasCapabilitySourceChanges'] else 'false'}",
                f"from_revision={upstream['fromRevision']}",
                f"to_revision={upstream['toRevision']}",
                f"status={value.get('status', 'ok')}",
                "",
            ]
        ),
        encoding="utf-8",
    )


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--manifest",
        type=Path,
        default=Path("Automation/capability-providers.json"),
        help="Path to the upstream provider manifest",
    )
    parser.add_argument(
        "--state",
        type=Path,
        default=Path("Automation/capability-sync-state.json"),
        help="Path to the last processed upstream revision",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(".automation/capability-drift.json"),
        help="Path for the machine-readable drift report",
    )
    parser.add_argument(
        "--markdown-output",
        type=Path,
        default=Path(".automation/capability-drift.md"),
        help="Path for the human-readable drift report",
    )
    parser.add_argument(
        "--github-output",
        type=Path,
        default=Path(os.environ["GITHUB_OUTPUT"]) if "GITHUB_OUTPUT" in os.environ else None,
        help="Optional GitHub Actions output file",
    )
    parser.add_argument(
        "--token",
        default=os.environ.get("GITHUB_TOKEN"),
        help="Optional token for GitHub API requests",
    )
    parser.add_argument(
        "--api-url",
        default="https://api.github.com",
        help="GitHub REST API base URL",
    )
    return parser.parse_args()


def main() -> int:
    arguments = parse_arguments()
    manifest = load_json(arguments.manifest)
    state = load_json(arguments.state)
    upstream = load_upstream(manifest)
    from_revision = load_revision(state, upstream.repository)
    source_paths = manifest.get("sourcePaths")
    if not isinstance(source_paths, dict):
        raise CapabilitySyncError("The provider manifest must contain a sourcePaths object")

    encoded_branch = urllib.parse.quote(upstream.branch, safe="")
    head_commit = api_request(
        arguments.api_url,
        f"repos/{upstream.repository}/commits/{encoded_branch}",
        arguments.token,
    )
    to_revision = head_commit.get("sha")
    if not isinstance(to_revision, str) or not re.fullmatch(r"[0-9a-f]{7,64}", to_revision):
        raise CapabilitySyncError(f"Could not read the current commit SHA for {upstream.repository}")

    blocked_comparison = load_blocked_comparison(state, upstream.repository)
    if blocked_comparison is not None and (
        blocked_comparison["fromRevision"] == from_revision
        and blocked_comparison["toRevision"] == to_revision
    ):
        result = report(
            upstream,
            from_revision,
            to_revision,
            [],
            status="comparison_already_blocked",
            blocked_comparison=blocked_comparison,
        )
    else:
        encoded_from = urllib.parse.quote(from_revision, safe="")
        encoded_to = urllib.parse.quote(to_revision, safe="")
        comparison = api_request(
            arguments.api_url,
            f"repos/{upstream.repository}/compare/{encoded_from}...{encoded_to}",
            arguments.token,
        )
        try:
            changed_files = capability_files(comparison, source_paths)
        except CapabilitySyncError as error:
            if "300-file limit" not in str(error):
                raise
            blocked_comparison = {
                "fromRevision": from_revision,
                "toRevision": to_revision,
                "reason": "github-compare-file-limit",
            }
            result = report(
                upstream,
                from_revision,
                to_revision,
                [],
                status="comparison_too_large",
                blocked_comparison=blocked_comparison,
            )
        else:
            result = report(upstream, from_revision, to_revision, changed_files)

    arguments.output.parent.mkdir(parents=True, exist_ok=True)
    arguments.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    arguments.markdown_output.parent.mkdir(parents=True, exist_ok=True)
    arguments.markdown_output.write_text(markdown_report(result), encoding="utf-8")
    if arguments.github_output is not None:
        write_github_output(arguments.github_output, result)

    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CapabilitySyncError as error:
        print(f"capability sync failed: {error}", file=sys.stderr)
        raise SystemExit(1) from error
