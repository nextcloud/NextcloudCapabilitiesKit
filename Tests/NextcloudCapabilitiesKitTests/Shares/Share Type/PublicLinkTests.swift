//
//  PublicLinkTests.swift
//  
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest
@testable import NextcloudCapabilitiesKit

final class PublicLinkTests: XCTestCase {

    func testPublicLinkInitialization() {
        let filesSharingCapabilities: [String: Any] = [
            "public": [
                "enabled": true,
                "upload": false,
                "supports_upload_only": true,
                "multiple": false,
                "password": [
                    "askForOptionalPassword": true,
                    "enforced": false
                ],
                "expire_date": [
                    "days": 10,
                    "enforced": true
                ],
                "expire_date_internal": [
                    "days": 5,
                    "enforced": true
                ],
                "expire_date_remote": [
                    "days": 7,
                    "enforced": false
                ]
            ]
        ]

        let publicLink = PublicLink(filesSharingCapabilities: filesSharingCapabilities)

        XCTAssertNotNil(publicLink, "PublicLink instance should not be nil")
        XCTAssertEqual(publicLink?.enabled, true, "Enabled should be true")
        XCTAssertEqual(publicLink?.allowUpload, false, "AllowUpload should be false")
        XCTAssertEqual(publicLink?.supportsUploadOnly, true, "SupportsUploadOnly should be true")
        XCTAssertEqual(publicLink?.askOptionalPassword, true, "AskOptionalPassword should be true")
        XCTAssertEqual(publicLink?.passwordEnforced, false, "PasswordEnforced should be false")
        XCTAssertEqual(publicLink?.expireDateEnforced, true, "ExpireDateEnforced should be true")
        XCTAssertEqual(publicLink?.expireDateDays, 10, "ExpireDateDays should be 10")
        XCTAssertEqual(publicLink?.internalExpireDateEnforced, true, "InternalExpireDateEnforced should be true")
        XCTAssertEqual(publicLink?.internalExpireDateDays, 5, "InternalExpireDateDays should be 5")
        XCTAssertEqual(publicLink?.remoteExpireDateEnforced, false, "RemoteExpireDateEnforced should be false")
        XCTAssertEqual(publicLink?.remoteExpireDateDays, 7, "RemoteExpireDateDays should be 7")
        XCTAssertEqual(publicLink?.multipleAllowed, false, "MultipleAllowed should be false")
    }

    func testInvalidPublicLinkInitialization() {
        let invalidFilesSharingCapabilities: [String: Any] = [
            "invalid_key": [
                "enabled": true,
            ]
        ]

        let publicLink = PublicLink(filesSharingCapabilities: invalidFilesSharingCapabilities)
        XCTAssertNil(publicLink, "PublicLink initialization should fail with an invalid public link dictionary")
    }

    func testPartiallyInvalidPublicLinkInitialization() {
        let partialFilesSharingCapabilities: [String: Any] = [
            "public": [
                "enabled": true,
                "upload": false,
            ]
        ]

        let publicLink = PublicLink(filesSharingCapabilities: partialFilesSharingCapabilities)

        XCTAssertNotNil(publicLink, "PublicLink instance should be created even with partial input")
        XCTAssertEqual(publicLink?.enabled, true, "Enabled should be true")
        XCTAssertEqual(publicLink?.allowUpload, false, "AllowUpload should be false")
        // Test default values for missing objects
        XCTAssertEqual(publicLink?.askOptionalPassword, false, "AskOptionalPassword should default to false")
        XCTAssertEqual(publicLink?.passwordEnforced, false, "PasswordEnforced should default to false")
        XCTAssertEqual(publicLink?.expireDateEnforced, false, "ExpireDateEnforced should default to false")
        XCTAssertEqual(publicLink?.expireDateDays, 1, "ExpireDateDays should default to 1")
        XCTAssertEqual(publicLink?.internalExpireDateEnforced, false, "InternalExpireDateEnforced should default to false")
        XCTAssertEqual(publicLink?.internalExpireDateDays, 1, "InternalExpireDateDays should default to 1")
        XCTAssertEqual(publicLink?.remoteExpireDateEnforced, false, "RemoteExpireDateEnforced should default to false")
        XCTAssertEqual(publicLink?.remoteExpireDateDays, 1, "RemoteExpireDateDays should default to 1")
    }
}
