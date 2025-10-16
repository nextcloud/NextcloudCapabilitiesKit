//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

class NotificationsTests: XCTestCase {
    func testNotificationsInitializationWithValidCapabilities() {
        // Valid notifications capabilities
        let capabilities: [String: Any] = [
            "notifications": [
                "ocs-endpoints": ["endpoint1", "endpoint2"],
                "push": ["push1", "push2"],
                "admin-notifications": ["notification1", "notification2"],
            ],
        ]

        let notifications = Notifications(capabilities: capabilities)
        XCTAssertNotNil(notifications, "Notifications instance should be created with valid input")
        XCTAssertEqual(notifications?.ocsEndpoints, ["endpoint1", "endpoint2"], "Notifications ocsEndpoints should match the provided value")
        XCTAssertEqual(notifications?.push, ["push1", "push2"], "Notifications push should match the provided value")
        XCTAssertEqual(notifications?.adminNotifications, ["notification1", "notification2"], "Notifications adminNotifications should match the provided value")
    }

    func testNotificationsInitializationWithInvalidCapabilities() {
        // Missing or invalid notifications capabilities
        let invalidCapabilities: [String: Any] = [:]
        let notifications = Notifications(capabilities: invalidCapabilities)
        XCTAssertNil(notifications, "Notifications instance should not be created with missing or invalid input")
    }

    func testNotificationsInitializationWithPartialInput() {
        // Partial notifications capabilities
        let capabilities: [String: Any] = [
            "notifications": [
                // Only providing part of the required properties
                "ocs-endpoints": ["partialEndpoint"],
            ],
        ]

        let notifications = Notifications(capabilities: capabilities)
        XCTAssertNotNil(notifications, "Notifications instance should be created with partial input")
        XCTAssertEqual(notifications?.ocsEndpoints, ["partialEndpoint"], "Notifications ocsEndpoints should match the provided value with partial input")
        XCTAssertEqual(notifications?.push, [], "Notifications push should default to an empty array with partial input")
        XCTAssertEqual(notifications?.adminNotifications, [], "Notifications adminNotifications should default to an empty array with partial input")
    }
}
