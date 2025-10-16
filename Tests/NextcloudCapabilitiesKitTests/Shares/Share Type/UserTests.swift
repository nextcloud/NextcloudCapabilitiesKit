//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: GPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

class UserTests: XCTestCase {
    func testValidUserInitialization() {
        // Valid user data with all required subobjects
        let validFilesSharingCapabilities: [String: Any] = [
            "user": [
                "send_mail": true,
                "expire_date": [
                    "enabled": true,
                ],
            ],
        ]

        let user = User(filesSharingCapabilities: validFilesSharingCapabilities)
        XCTAssertNotNil(user, "User instance should be created with valid input")
        XCTAssertEqual(user?.sendMail, true, "SendMail should be true")
        XCTAssertEqual(user?.expireDateEnabled, true, "ExpireDateEnabled should be true")
    }

    func testInvalidUserInitialization() {
        let invalidFilesSharingCapabilities: [String: Any] = [:]
        let user = User(filesSharingCapabilities: invalidFilesSharingCapabilities)
        XCTAssertNil(user, "User instance should not be created with invalid input")
    }

    func testPartiallyValidUserInitialization() {
        let partialFilesSharingCapabilities: [String: Any] = [
            "user": [
                "send_mail": true,
                // Missing "expire_date" subobject
            ],
        ]

        let user = User(filesSharingCapabilities: partialFilesSharingCapabilities)
        XCTAssertNotNil(user, "User instance should be created even with partially valid input")
        XCTAssertEqual(user?.sendMail, true, "SendMail should be true")
        XCTAssertEqual(user?.expireDateEnabled, false, "ExpireDateEnabled should default to false when subobject is missing")
    }
}
