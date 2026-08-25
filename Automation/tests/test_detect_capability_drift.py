# SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
# SPDX-License-Identifier: LGPL-3.0-or-later

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from detect_capability_drift import (
    CapabilitySyncError,
    ChangedFile,
    Upstream,
    capability_files,
    is_capability_source,
    load_blocked_comparison,
    markdown_report,
    report,
    write_github_output,
)


class CapabilitySourceTests(unittest.TestCase):
    source_paths = {
        "exact": ["core/AppInfo/Capabilities.php"],
        "providerFileSuffixes": ["Capability.php", "Capabilities.php"],
        "registrationFiles": ["appinfo/Application.php", "appinfo/info.xml"],
    }

    def test_matches_core_provider(self) -> None:
        self.assertTrue(is_capability_source("core/AppInfo/Capabilities.php", self.source_paths))

    def test_matches_nested_app_provider(self) -> None:
        self.assertTrue(is_capability_source("apps/files/lib/AdvancedCapabilities.php", self.source_paths))

    def test_matches_capability_registration(self) -> None:
        self.assertTrue(is_capability_source("apps/dav/appinfo/Application.php", self.source_paths))

    def test_ignores_unrelated_app_source(self) -> None:
        self.assertFalse(is_capability_source("apps/dav/lib/Connector/Sabre/ServerFactory.php", self.source_paths))

    def test_includes_renamed_provider(self) -> None:
        changed = capability_files(
            {
                "files": [
                    {
                        "filename": "apps/dav/lib/DavCapabilities.php",
                        "status": "renamed",
                        "previous_filename": "apps/dav/lib/Capabilities.php",
                    }
                ]
            },
            self.source_paths,
        )

        self.assertEqual(
            changed,
            [
                ChangedFile(
                    filename="apps/dav/lib/DavCapabilities.php",
                    status="renamed",
                    previous_filename="apps/dav/lib/Capabilities.php",
                )
            ],
        )

    def test_rejects_truncated_compare_response(self) -> None:
        with self.assertRaisesRegex(CapabilitySyncError, "300-file limit"):
            capability_files({"files": [{}] * 300}, self.source_paths)

    def test_loads_blocked_comparison(self) -> None:
        blocked = load_blocked_comparison(
            {
                "upstreams": {
                    "nextcloud/server": {
                        "revision": "a" * 40,
                        "blockedComparison": {
                            "fromRevision": "a" * 40,
                            "toRevision": "b" * 40,
                            "reason": "github-compare-file-limit",
                        },
                    }
                }
            },
            "nextcloud/server",
        )

        self.assertEqual(
            blocked,
            {
                "fromRevision": "a" * 40,
                "toRevision": "b" * 40,
                "reason": "github-compare-file-limit",
            },
        )

    def test_renders_oversized_comparison_as_manual_review(self) -> None:
        value = report(
            Upstream(repository="nextcloud/server", branch="master"),
            "a" * 40,
            "b" * 40,
            [],
            status="comparison_too_large",
            blocked_comparison={
                "fromRevision": "a" * 40,
                "toRevision": "b" * 40,
                "reason": "github-compare-file-limit",
            },
        )

        rendered = markdown_report(value)

        self.assertIn("requires manual review", rendered)
        self.assertIn("300-file compare limit", rendered)

    def test_builds_human_readable_report(self) -> None:
        value = report(
            Upstream(repository="nextcloud/server", branch="master"),
            "a" * 40,
            "b" * 40,
            [ChangedFile(filename="apps/dav/lib/Capabilities.php", status="modified", previous_filename=None)],
        )

        rendered = markdown_report(value)

        self.assertIn("Nextcloud capability source change", rendered)
        self.assertIn("apps/dav/lib/Capabilities.php", rendered)
        self.assertIn("compare/", rendered)

    def test_writes_github_action_outputs(self) -> None:
        value = report(
            Upstream(repository="nextcloud/server", branch="master"),
            "a" * 40,
            "b" * 40,
            [],
        )
        output = Path(self.id().replace(".", "_"))
        self.addCleanup(output.unlink, missing_ok=True)

        write_github_output(output, value)

        self.assertEqual(
            output.read_text(encoding="utf-8"),
            f"changed=false\nfrom_revision={'a' * 40}\nto_revision={'b' * 40}\nstatus=ok\n",
        )
