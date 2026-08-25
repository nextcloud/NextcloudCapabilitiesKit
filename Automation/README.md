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
at a time for a new upstream revision.

The workflow provisions Swift 6 in the agent job and builds the pinned
SwiftFormat package before the agent starts, so `swift test` and
`swiftformat --lint .` are available inside the sandbox. The state file remains
review-gated: merging a sync PR updates the processed revision, which the next
scheduled poll observes without directly mutating `main` from the agent.

If GitHub's compare API returns its 300-file limit, the agent creates a
state-only draft PR recording `blockedComparison` without advancing the
revision. Once merged, subsequent runs report the same range as already
blocked instead of retrying it. Manual partitioning or a deliberate state
advance is then required.

The workflow authenticates Copilot with the repository secret
`COPILOT_GITHUB_TOKEN`; the token must be a fine-grained PAT with the Copilot
Requests account permission. The main agent job has read-only permissions.
Pull requests are created by the
workflow's constrained safe output, which accepts changes only to capability
models, tests, and `capability-sync-state.json`; no upstream repository
workflow or webhook configuration is required.

The provider paths are intentionally declarative in
`capability-providers.json`. Add external Nextcloud app repositories only when
their capability contracts should be tracked by the same workflow.
