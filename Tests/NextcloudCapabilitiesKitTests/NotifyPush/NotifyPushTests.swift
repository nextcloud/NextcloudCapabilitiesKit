//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: GPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

class NotifyPushTests: XCTestCase {
    func testNotifyPushInitializationWithValidCapabilities() {
        // Valid notify push capabilities
        let validCapabilities: [String: Any] = [
            "notify_push": [
                "type": ["files", "activities"],
            ],
        ]

        let notifyPush = NotifyPush(capabilities: validCapabilities)
        XCTAssertNotNil(notifyPush, "NotifyPush instance should be created with valid input")
        XCTAssertTrue(notifyPush?.available ?? false, "NotifyPush should be available")
        XCTAssertTrue(notifyPush?.types.contains(.files) ?? false, "NotifyPush types should contain .files")
        XCTAssertTrue(notifyPush?.types.contains(.activities) ?? false, "NotifyPush types should contain .activities")
        XCTAssertNil(notifyPush?.endpoints, "NotifyPush endpoints should be nil when not provided")
    }

    func testNotifyPushInitializationWithUnavailableCapabilities() {
        // Missing notify push capabilities
        let invalidCapabilities: [String: Any] = [:]
        let notifyPush = NotifyPush(capabilities: invalidCapabilities)
        XCTAssertNil(notifyPush, "NotifyPush instance should not be created with unavailable input")
    }

    func testNotifyPushInitializationWithPartiallyValidCapabilities() {
        // Partially valid notify push capabilities
        let partiallyValidCapabilities: [String: Any] = [
            "notify_push": [
                "type": ["files", "invalidType"],
            ],
        ]

        let notifyPush = NotifyPush(capabilities: partiallyValidCapabilities)
        XCTAssertNotNil(notifyPush, "NotifyPush instance should be created with partially valid input")
        XCTAssertTrue(notifyPush?.available ?? false, "NotifyPush should be available")
        XCTAssertTrue(notifyPush?.types.contains(.files) ?? false, "NotifyPush types should contain .files")
        XCTAssertFalse(notifyPush?.types.contains(.notifications) ?? true, "NotifyPush types should not contain .notifications with partially valid input")
        XCTAssertNil(notifyPush?.endpoints, "NotifyPush endpoints should be nil when not provided")
    }
}
