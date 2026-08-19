//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

class FilesSharingTests: XCTestCase {
    func testValidFilesSharingInitialization() {
        // Valid files sharing capabilities with all required subobjects
        let validCapabilities: [String: Any] = [
            "files_sharing": [
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
                ],
                "public": [
                    "enabled": true,
                    "upload": false,
                    "upload_files_drop": true,
                    "send_mail": true,
                    "custom_tokens": true,
                    "multiple_links": false,
                    "password": [
                        "askForOptionalPassword": true,
                        "enforced": false
                    ],
                    "expire_date": [
                        "enabled": true,
                        "days": 10,
                        "enforced": true
                    ],
                    "expire_date_internal": [
                        "enabled": true,
                        "days": 5,
                        "enforced": true
                    ],
                    "expire_date_remote": [
                        "enabled": true,
                        "days": 7,
                        "enforced": false
                    ]
                ],
                "user": [
                    "send_mail": true,
                    "expire_date": [
                        "enabled": true
                    ]
                ],
                "group": [
                    "enabled": true,
                    "expire_date": [
                        "enabled": false
                    ]
                ],
                "federation": [
                    "outgoing": true,
                    "incoming": false,
                    "expire_date": [
                        "enabled": true
                    ],
                    "expire_date_supported": [
                        "enabled": false
                    ]
                ],
                "sharee": [
                    "minSearchStringLength": 3,
                    "query_lookup_default": true,
                    "always_show_unique": false
                ],
                "api_enabled": true,
                "resharing": false,
                "group_sharing": true,
                "default_permissions": 31,
                "exclude_reshare_from_edit": true
            ]
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
        XCTAssertEqual(filesSharing?.groupSharing, true, "Group sharing should be true")
        XCTAssertEqual(filesSharing?.defaultPermissions, 31, "DefaultPermissions should be 31")
        XCTAssertEqual(filesSharing?.excludeReshareFromEdit, true, "Exclude reshare from edit should be true")
        XCTAssertEqual(filesSharing?.email?.sendsPasswordByEmail, true, "Share by mail should send passwords")
        XCTAssertEqual(filesSharing?.publicLink?.customTokens, true, "Public links should support custom tokens")
        XCTAssertEqual(filesSharing?.sharee?.minSearchStringLength, 3, "Sharee search length should match the provided value")
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
                "api_enabled": true
                // Missing "resharing" and "default_permissions"
            ]
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
