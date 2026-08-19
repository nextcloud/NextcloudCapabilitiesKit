//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

class DavTests: XCTestCase {
    func testDavInitializationWithValidCapabilities() {
        // Valid dav capabilities
        let capabilities: [String: Any] = [
            "dav": [
                "chunking": "1.0",
                "public_shares_chunking": true,
                "search_supports_creation_time": true,
                "search_supports_upload_time": true,
                "search_supports_last_activity": true,
                "bulkupload": "1.0",
                "absence-supported": true,
                "absence-replacement": true
            ]
        ]

        let dav = Dav(capabilities: capabilities)
        XCTAssertNotNil(dav, "Dav instance should be created with valid input")
        XCTAssertEqual(dav?.chunking, "1.0", "Dav chunking should match the provided value")
        XCTAssertEqual(dav?.publicSharesChunking, true, "Dav public shares chunking should match the provided value")
        XCTAssertEqual(dav?.searchSupportsCreationTime, true, "Dav creation time search should match the provided value")
        XCTAssertEqual(dav?.searchSupportsUploadTime, true, "Dav upload time search should match the provided value")
        XCTAssertEqual(dav?.searchSupportsLastActivity, true, "Dav activity search should match the provided value")
        XCTAssertEqual(dav?.bulkUpload, "1.0", "Dav bulkUpload should match the provided value")
        XCTAssertEqual(dav?.absenceSupported, true, "Dav absence support should match the provided value")
        XCTAssertEqual(dav?.absenceReplacement, true, "Dav absence replacement should match the provided value")
    }

    func testDavInitializationWithInvalidCapabilities() {
        // Missing or invalid dav capabilities
        let invalidCapabilities: [String: Any] = [:]
        let dav = Dav(capabilities: invalidCapabilities)
        XCTAssertNil(dav, "Dav instance should not be created with missing or invalid input")
    }

    func testDavInitializationWithPartialInput() {
        // Partial dav capabilities
        let capabilities: [String: Any] = [
            "dav": [
                // Only providing part of the required properties
                "chunking": "1.0"
            ]
        ]

        let dav = Dav(capabilities: capabilities)
        XCTAssertNotNil(dav, "Dav instance should be created with partial input")
        XCTAssertEqual(dav?.chunking, "1.0", "Dav chunking should match the provided value with partial input")
        XCTAssertNil(dav?.bulkUpload, "Dav bulkUpload should be nil when it is not provided")
    }
}
