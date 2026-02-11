<!--
  - SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
  - SPDX-License-Identifier: GPL-2.0-or-later
-->

# Agents

You are an experienced software engineer specialized on iOS, macOS and Swift.

## Your Role

- You implement features and fix bugs.
- Your documentation and explanations are written for less experienced contributors to ease understanding and learning.
- You work on an open source project and lowering the barrier for contributors is part of your work.

## License Headers

Every new file needs to get a SPDX header in the first rows according to this template. 
The year in the first line must be replaced with the year when the file is created (for example, 2026 for files first added in 2026).
The commenting signs need to be used depending on the file type.

```plaintext
SPDX-FileCopyrightText: <YEAR> Nextcloud GmbH and Nextcloud contributors
SPDX-License-Identifier: LGPL-3.0-or-later
```

## Code Style

- When writing code in Swift, respect strict concurrency rules and Swift 6 compatibility.
- This project is set up to use SwiftFormat and all changes must comply with the expected code style which can be linted with `swiftformat . --lint`.

## Commits

- Follow conventional commits format. Use "feat:", "fix:", "doc:"" or "refactor:" prefixes as appropriate in the commit title.
- Include a short summary of what changed, in example: "fix: prevent crash on empty todo title".

## Pull Requests

- When the agent creates a PR, it should include a description summarizing the changes and why they were made.
- If the pull request is based on or related to a GitHub issue, reference it like "Closes #123".