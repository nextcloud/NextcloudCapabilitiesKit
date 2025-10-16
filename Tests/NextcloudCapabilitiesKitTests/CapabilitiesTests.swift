//
//  CapabilitiesTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

@testable import NextcloudCapabilitiesKit
import XCTest

class CapabilitiesTests: XCTestCase {
    func testCapabilitiesInitializationWithValidData() {
        // Valid capabilities data
        let validData = """
        {
            "ocs": {
                "data": {
                    "capabilities": {
                        "core": {
                            "webdav-root": "remote.php/webdav"
                        },
                        "dav": {
                            "chunking": "1.0"
                        },
                        "files": {
                            "bigfilechunking": true
                        },
                    }
                }
            }
        }
        """.data(using: .utf8)!

        let capabilities = Capabilities(data: validData)
        XCTAssertNotNil(capabilities, "Capabilities instance should be created with valid data")
    }

    func testCapabilitiesInitializationWithInvalidData() {
        // Invalid capabilities data
        let invalidData = Data()
        let capabilities = Capabilities(data: invalidData)
        XCTAssertNil(capabilities, "Capabilities instance should not be created with invalid data")
    }
}
