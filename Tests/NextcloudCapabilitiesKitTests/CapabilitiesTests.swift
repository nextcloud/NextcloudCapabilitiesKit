//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import XCTest

class CapabilitiesTests: XCTestCase {
    func testCapabilitiesInitializationWithValidData() {
        // Valid capabilities data with version
        let validData = """
        {
            "ocs": {
                "data": {
                    "version": {
                        "major": 31,
                        "minor": 0,
                        "micro": 9
                    },
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
        XCTAssertEqual(capabilities?.major, 31, "Major version should be 31")
        XCTAssertEqual(capabilities?.minor, 0, "Minor version should be 0")
        XCTAssertEqual(capabilities?.patch, 9, "Patch version should be 9")
    }

    func testCapabilitiesInitializationWithInvalidData() {
        // Invalid capabilities data
        let invalidData = Data()
        let capabilities = Capabilities(data: invalidData)
        XCTAssertNil(capabilities, "Capabilities instance should not be created with invalid data")
    }

    func testCapabilitiesInitializationWithMissingVersion() {
        // Valid capabilities data but missing version
        let dataWithoutVersion = """
        {
            "ocs": {
                "data": {
                    "capabilities": {
                        "core": {
                            "webdav-root": "remote.php/webdav"
                        }
                    }
                }
            }
        }
        """.data(using: .utf8)!

        let capabilities = Capabilities(data: dataWithoutVersion)
        XCTAssertNil(capabilities, "Capabilities instance should not be created without version information")
    }

    func testCapabilitiesInitializationWithDifferentVersions() {
        // Test with different version numbers
        let dataWithVersion = """
        {
            "ocs": {
                "data": {
                    "version": {
                        "major": 28,
                        "minor": 5,
                        "micro": 12
                    },
                    "capabilities": {
                        "core": {
                            "webdav-root": "remote.php/webdav"
                        }
                    }
                }
            }
        }
        """.data(using: .utf8)!

        let capabilities = Capabilities(data: dataWithVersion)
        XCTAssertNotNil(capabilities, "Capabilities instance should be created with valid version data")
        XCTAssertEqual(capabilities?.major, 28, "Major version should be 28")
        XCTAssertEqual(capabilities?.minor, 5, "Minor version should be 5")
        XCTAssertEqual(capabilities?.patch, 12, "Patch version should be 12")
    }
}
