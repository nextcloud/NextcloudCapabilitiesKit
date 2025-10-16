//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import XCTest

@testable import NextcloudCapabilitiesKit

class ShareeTests: XCTestCase {
    func testValidShareeInitialization() {
        // Valid sharee capabilities
        let validCapabilities: [String: Any] = [
            "sharee": [
                "query_lookup_default": true,
                "always_show_unique": false,
            ],
        ]

        let sharee = Sharee(filesSharingCapabilities: validCapabilities)
        XCTAssertNotNil(sharee, "Sharee instance should be created with valid input")
        XCTAssertEqual(sharee?.queryLookupDefault, true, "Query Lookup Default should be true")
        XCTAssertEqual(sharee?.alwaysShowUnique, false, "Always Show Unique should be false")
    }

    func testInvalidShareeInitialization() {
        let invalidCapabilities: [String: Any] = [:]
        let sharee = Sharee(filesSharingCapabilities: invalidCapabilities)
        XCTAssertNil(sharee, "Sharee instance should not be created with invalid input")
    }

    func testPartiallyValidShareeInitialization() {
        // Partially valid sharee capabilities with some values missing
        let partialCapabilities: [String: Any] = [
            "sharee": [:],
            // Missing "query_lookup_default" and "always_show_unique" values
        ]

        let sharee = Sharee(filesSharingCapabilities: partialCapabilities)
        XCTAssertNotNil(sharee, "Sharee instance should be created even with partially valid input")
        XCTAssertEqual(sharee?.queryLookupDefault, false, "Query Lookup Default should default to false")
        XCTAssertEqual(sharee?.alwaysShowUnique, false, "Always Show Unique should default to false")
    }
}
