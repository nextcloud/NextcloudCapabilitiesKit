//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

class CoreTests: XCTestCase {
    func testCoreInitializationWithValidCapabilities() {
        // Valid core capabilities
        let capabilities: [String: Any] = [
            "core": [
                "pollinterval": 30,
                "webdav-root": "custom/webdav",
                "reference-api": true,
                "reference-regex": "^[a-zA-Z0-9]*$",
                "mod-rewrite-working": true,
                "user": [
                    "language": "en",
                    "locale": "en_US",
                    "timezone": "Europe/Berlin"
                ],
                "can-create-app-token": true
            ]
        ]

        let core = Core(capabilities: capabilities)
        XCTAssertNotNil(core, "Core instance should be created with valid input")
        XCTAssertEqual(core?.pollInterval, 30, "Core pollInterval should match the provided value")
        XCTAssertEqual(core?.webdavRoot, "custom/webdav", "Core webdavRoot should match the provided value")
        XCTAssertTrue(core?.referenceApi ?? false, "Core referenceApi should match the provided value")
        XCTAssertEqual(core?.referenceRegex, "^[a-zA-Z0-9]*$", "Core referenceRegex should match the provided value")
        XCTAssertTrue(core?.modRewriteWorking ?? false, "Core modRewriteWorking should match the provided value")
        XCTAssertEqual(core?.user?.language, "en", "Core user language should match the provided value")
        XCTAssertEqual(core?.user?.locale, "en_US", "Core user locale should match the provided value")
        XCTAssertEqual(core?.user?.timeZone, "Europe/Berlin", "Core user timezone should match the provided value")
        XCTAssertEqual(core?.canCreateAppToken, true, "Core app token capability should match the provided value")
    }

    func testCoreInitializationWithInvalidCapabilities() {
        // Missing or invalid core capabilities
        let invalidCapabilities: [String: Any] = [:]
        let core = Core(capabilities: invalidCapabilities)
        XCTAssertNil(core, "Core instance should not be created with missing or invalid input")
    }

    func testCoreInitializationWithPartialInput() {
        // Partial core capabilities
        let capabilities: [String: Any] = [
            "core": [
                // Only providing part of the required properties
                "pollinterval": 45
            ]
        ]

        let core = Core(capabilities: capabilities)
        XCTAssertNotNil(core, "Core instance should be created with partial input")
        XCTAssertEqual(core?.pollInterval, 45, "Core pollInterval should match the provided value with partial input")
        XCTAssertEqual(core?.webdavRoot, "remote.php/webdav", "Core webdavRoot should default to 'remote.php/webdav' with partial input")
        XCTAssertFalse(core?.referenceApi ?? true, "Core referenceApi should default to false with partial input")
        XCTAssertEqual(core?.referenceRegex, "", "Core referenceRegex should default to an empty string with partial input")
        XCTAssertFalse(core?.modRewriteWorking ?? true, "Core modRewriteWorking should default to false with partial input")
        XCTAssertNil(core?.user, "Core user should be nil when it is not provided")
        XCTAssertNil(core?.canCreateAppToken, "Core app token capability should be nil when it is not provided")
    }
}
