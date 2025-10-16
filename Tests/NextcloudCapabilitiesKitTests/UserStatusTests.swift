//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: GPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

class UserStatusTests: XCTestCase {
    func testUserStatusInitializationWithValidCapabilities() {
        // Valid user status capabilities
        let capabilities: [String: Any] = [
            "user_status": [
                "enabled": true,
                "restore": false,
                "supports_emoji": true,
            ],
        ]

        let userStatus = UserStatus(capabilities: capabilities)
        XCTAssertNotNil(userStatus, "UserStatus instance should be created with valid input")
        XCTAssertTrue(userStatus?.enabled ?? false, "UserStatus enabled should be true")
        XCTAssertFalse(userStatus?.restore ?? true, "UserStatus restore should be false")
        XCTAssertTrue(userStatus?.supportsEmoji ?? false, "UserStatus supportsEmoji should be true")
    }

    func testUserStatusInitializationWithMissingCapabilities() {
        // Missing user status capabilities
        let invalidCapabilities: [String: Any] = [:]
        let userStatus = UserStatus(capabilities: invalidCapabilities)
        XCTAssertNil(userStatus, "UserStatus instance should not be created with missing input")
    }

    func testUserStatusInitializationWithPartialInput() {
        // Partial user status capabilities
        let capabilities: [String: Any] = [
            "user_status": [
                // Only providing part of the required properties
                "enabled": false,
            ],
        ]

        let userStatus = UserStatus(capabilities: capabilities)
        XCTAssertNotNil(userStatus, "UserStatus instance should be created with partial input")
        XCTAssertFalse(userStatus?.enabled ?? true, "UserStatus enabled should be false with partial input")
        XCTAssertFalse(userStatus?.restore ?? true, "UserStatus restore should default to false with partial input")
        XCTAssertFalse(userStatus?.supportsEmoji ?? true, "UserStatus supportsEmoji should default to false with partial input")
    }
}
