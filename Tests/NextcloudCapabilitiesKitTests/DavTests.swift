//
//  DavTests.swift
//  
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest
@testable import NextcloudCapabilitiesKit

class DavTests: XCTestCase {

    func testDavInitializationWithValidCapabilities() {
        // Valid dav capabilities
        let capabilities: [String: Any] = [
            "dav": [
                "chunking": "1.0",
                "bulkupload": "1.0"
            ]
        ]

        let dav = Dav(capabilities: capabilities)
        XCTAssertNotNil(dav, "Dav instance should be created with valid input")
        XCTAssertEqual(dav?.chunking, "1.0", "Dav chunking should match the provided value")
        XCTAssertEqual(dav?.bulkUpload, "1.0", "Dav bulkUpload should match the provided value")
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
        XCTAssertEqual(dav?.bulkUpload, "", "Dav bulkUpload should default to an empty string with partial input")
    }
}
