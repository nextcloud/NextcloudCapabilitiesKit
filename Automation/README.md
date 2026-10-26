<!--
  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
  SPDX-License-Identifier: LGPL-3.0-or-later
-->

# Capability sync automation

This directory contains a self-contained watcher for capability providers in
[`nextcloud/server`](https://github.com/nextcloud/server). It requires no
workflow or webhook in the upstream repository.

`capability-sync.md` is a GitHub Agentic Workflow that polls
`nextcloud/server` every six hours and can also be started manually. Its generated
`capability-sync.lock.yml` executes the workflow. The agent runs the detector,
interprets changed provider sources, and opens at most one draft pull request
at a time when a confirmed public capabilities contract change requires a
Swift model or focused test update. Provider refactoring and upstream revision
changes alone produce a quiet no-op, with the explanation kept in the workflow
run. They do not create a pull request or fallback issue.

The workflow uses GitHub's Ubuntu 24.04 runner, which includes Swift 6, and
builds the pinned SwiftFormat package before the agent starts. This makes
`swift test` and `swiftformat --lint .` available inside the sandbox without
downloading a separate Swift toolchain. The state file remains
review-gated: merging a substantive sync PR updates the revision, which the
next scheduled poll observes. The revision records the last substantive sync;
quiet runs leave it unchanged and may reassess the same upstream range on later
polls. No separate hash-only update is needed to keep watching for changes.

The detector compares only the configured capability-provider paths between
the two upstream commit snapshots. Large unrelated server changes therefore
do not consume GitHub's 300-file comparison limit. Added, removed, and modified
provider or registration files are reported for agent review.

The workflow authenticates Copilot with the repository secret
`COPILOT_GITHUB_TOKEN`; the token must be a fine-grained PAT with the Copilot
Requests account permission. The main agent job has read-only permissions.
Pull requests are created by the
workflow's constrained safe output, which accepts changes only to capability
models, tests, and `capability-sync-state.json`; no upstream repository
workflow or webhook configuration is required.

Before publishing safe outputs, a deterministic step converts any hash-only
pull request request into a quiet no-op. It uses gh-aw's patch parser and
transport-path resolver to inspect the generated patch before a branch, PR, or
fallback issue is created. The agent still determines whether a source change
actually alters the public contract; the deterministic step prevents state-only
patches from being published even if the agent requests one.

The provider paths are intentionally declarative in
`capability-providers.json`. Add external Nextcloud app repositories only when
their capability contracts should be tracked by the same workflow.
