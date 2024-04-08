//
//  ActivityTests.swift
//  
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest
@testable import NextcloudCapabilitiesKit

class ActivityTests: XCTestCase {

    func testActivityInitializationWithValidCapabilities() {
        // Valid activity capabilities
        let capabilities: [String: Any] = [
            "activity": [
                "apiv2": ["endpoint1", "endpoint2"]
            ]
        ]

        let activity = Activity(capabilities: capabilities)
        XCTAssertNotNil(activity, "Activity instance should be created with valid input")
        XCTAssertEqual(activity?.apiV2, ["endpoint1", "endpoint2"], "Activity apiV2 should match the provided values")
    }

    func testActivityInitializationWithInvalidCapabilities() {
        // Missing or invalid activity capabilities
        let invalidCapabilities: [String: Any] = [:]
        let activity = Activity(capabilities: invalidCapabilities)
        XCTAssertNil(activity, "Activity instance should not be created with missing or invalid input")
    }

    func testActivityInitializationWithPartialInput() {
        // Partial activity capabilities
        let capabilities: [String: Any] = ["activity": [:]]

        let activity = Activity(capabilities: capabilities)
        XCTAssertNotNil(activity, "Activity instance should be created with partial input")
        XCTAssertEqual(activity?.apiV2, [], "Activity apiV2 should be empty with partial input")
    }
}
