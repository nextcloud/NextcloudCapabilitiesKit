# SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
# SPDX-License-Identifier: LGPL-3.0-or-later

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from detect_capability_drift import (
    ChangedFile,
    Upstream,
    capability_tree_changes,
    is_capability_source,
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

    def test_detects_capability_changes_from_tree_snapshots(self) -> None:
        changed = capability_tree_changes(
            {
                "core/AppInfo/Capabilities.php": "core-old",
                "apps/dav/lib/Capabilities.php": "dav-same",
                "apps/dav/appinfo/info.xml": "dav-registration-old",
                "unrelated.php": "unrelated-old",
            },
            {
                "core/AppInfo/Capabilities.php": "core-new",
                "apps/dav/lib/Capabilities.php": "dav-same",
                "apps/files/lib/FilesCapabilities.php": "files-new",
                "unrelated.php": "unrelated-new",
            },
            self.source_paths,
        )

        self.assertEqual(
            changed,
            [
                ChangedFile(
                    filename="apps/dav/appinfo/info.xml",
                    status="removed",
                    previous_filename=None,
                ),
                ChangedFile(
                    filename="apps/files/lib/FilesCapabilities.php",
                    status="added",
                    previous_filename=None,
                ),
                ChangedFile(
                    filename="core/AppInfo/Capabilities.php",
                    status="modified",
                    previous_filename=None,
                ),
            ],
        )

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
