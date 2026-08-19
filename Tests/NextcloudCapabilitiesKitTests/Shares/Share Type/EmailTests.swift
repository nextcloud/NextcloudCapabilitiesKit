//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

final class EmailTests: XCTestCase {
    func testEmailInitializationWithValidData() {
        // Prepare test data
        let filesSharingCapabilities: [String: Any] = [
            "sharebymail": [
                "enabled": true,
                "send_password_by_mail": true,
                "upload_files_drop": [
                    "enabled": true
                ],
                "password": [
                    "enabled": true,
                    "enforced": false
                ],
                "expire_date": [
                    "enabled": true,
                    "enforced": true
                ]
            ]
        ]

        let email = Email(filesSharingCapabilities: filesSharingCapabilities)
        XCTAssertNotNil(email)
        XCTAssertEqual(email?.enabled, true)
        XCTAssertEqual(email?.sendsPasswordByEmail, true)
        XCTAssertEqual(email?.uploadFilesDropEnabled, true)
        XCTAssertEqual(email?.passwordEnabled, true)
        XCTAssertEqual(email?.passwordEnforced, false)
        XCTAssertEqual(email?.expireDateEnabled, true)
        XCTAssertEqual(email?.expireDateEnforced, true)
    }

    func testEmailInitializationWithMissingData() {
        let filesSharingCapabilities: [String: Any] = [:]
        let email = Email(filesSharingCapabilities: filesSharingCapabilities)
        XCTAssertNil(email)
    }
}
