//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import XCTest

@testable import NextcloudCapabilitiesKit

class FilesSharingTests: XCTestCase {
    func testValidFilesSharingInitialization() {
        // Valid files sharing capabilities with all required subobjects
        let validCapabilities: [String: Any] = [
            "files_sharing": [
                "sharebymail": [
                    "password": [
                        "enabled": true,
                        "enforced": false,
                    ],
                ],
                "public": [
                    "enabled": true,
                    "upload": false,
                    "supports_upload_only": true,
                    "multiple": false,
                    "password": [
                        "askForOptionalPassword": true,
                        "enforced": false,
                    ],
                    "expire_date": [
                        "days": 10,
                        "enforced": true,
                    ],
                    "expire_date_internal": [
                        "days": 5,
                        "enforced": true,
                    ],
                    "expire_date_remote": [
                        "days": 7,
                        "enforced": false,
                    ],
                ],
                "user": [
                    "send_mail": true,
                    "expire_date": [
                        "enabled": true,
                    ],
                ],
                "group": [
                    "enabled": true,
                    "expire_date": [
                        "enabled": false,
                    ],
                ],
                "federation": [
                    "outgoing": true,
                    "incoming": false,
                    "expire_date": [
                        "enabled": true,
                    ],
                    "expire_date_supported": [
                        "enabled": false,
                    ],
                ],
                "sharee": [
                    "query_lookup_default": true,
                    "always_show_unique": false,
                ],
                "api_enabled": true,
                "resharing": false,
                "default_permissions": 31,
            ],
        ]

        let filesSharing = FilesSharing(capabilities: validCapabilities)
        XCTAssertNotNil(filesSharing, "FilesSharing instance should be created with valid input")
        XCTAssertNotNil(filesSharing?.email, "ShareByMail subobject should be initialized")
        XCTAssertNotNil(filesSharing?.publicLink, "Public subobject should be initialized")
        XCTAssertNotNil(filesSharing?.user, "User subobject should be initialized")
        XCTAssertNotNil(filesSharing?.group, "Group subobject should be initialized")
        XCTAssertNotNil(filesSharing?.federation, "Federation subobject should be initialized")
        XCTAssertNotNil(filesSharing?.sharee, "Sharee subobject should be initialized")
        XCTAssertEqual(filesSharing?.apiEnabled, true, "APIEnabled should be true")
        XCTAssertEqual(filesSharing?.resharing, false, "Resharing should be false")
        XCTAssertEqual(filesSharing?.defaultPermissions, 31, "DefaultPermissions should be 755")
    }

    func testInvalidFilesSharingInitialization() {
        // Missing required subobjects in files sharing capabilities
        let invalidCapabilities: [String: Any] = [:]
        let filesSharing = FilesSharing(capabilities: invalidCapabilities)
        XCTAssertNil(filesSharing, "FilesSharing instance should not be created with invalid input")
    }

    func testPartiallyValidFilesSharingInitialization() {
        // Partially valid files sharing capabilities with some subobjects missing
        let partialCapabilities: [String: Any] = [
            "files_sharing": [
                "sharebymail": [:],
                // Missing "public_link" and "user" subobjects
                "group": [:],
                "federation": [:],
                "sharee": [:],
                "api_enabled": true,
                // Missing "resharing" and "default_permissions"
            ],
        ]

        let filesSharing = FilesSharing(capabilities: partialCapabilities)

        XCTAssertNotNil(filesSharing, "FilesSharing instance should be created even with partially valid input")
        XCTAssertNotNil(filesSharing?.email, "ShareByMail subobject should be initialized")
        XCTAssertNil(filesSharing?.publicLink, "Public subobject should default to nil")
        XCTAssertNil(filesSharing?.user, "User subobject should default to nil")
        XCTAssertNotNil(filesSharing?.group, "Group subobject should be initialized")
        XCTAssertNotNil(filesSharing?.federation, "Federation subobject should be initialized")
        XCTAssertNotNil(filesSharing?.sharee, "Sharee subobject should be initialized")
        XCTAssertEqual(filesSharing?.apiEnabled, true, "APIEnabled should be true")
        XCTAssertEqual(filesSharing?.resharing, false, "Resharing should default to false")
        XCTAssertEqual(filesSharing?.defaultPermissions, 0, "DefaultPermissions should default to 0")
    }
}
