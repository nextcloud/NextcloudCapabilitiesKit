//
//  BruteForceTests.swift
//  
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest
@testable import NextcloudCapabilitiesKit

class BruteForceTests: XCTestCase {

    func testBruteForceInitializationWithValidCapabilities() {
        // Valid bruteforce capabilities
        let capabilities: [String: Any] = [
            "bruteforce": [
                "delay": 5,
                "allow-listed": true
            ]
        ]

        let bruteForce = BruteForce(capabilities: capabilities)
        XCTAssertNotNil(bruteForce, "BruteForce instance should be created with valid input")
        XCTAssertEqual(bruteForce?.delay, 5, "BruteForce delay should match the provided value")
        XCTAssertTrue(bruteForce?.allowListed ?? false, "BruteForce allowListed should match the provided value")
    }

    func testBruteForceInitializationWithInvalidCapabilities() {
        // Missing or invalid bruteforce capabilities
        let invalidCapabilities: [String: Any] = [:]
        let bruteForce = BruteForce(capabilities: invalidCapabilities)
        XCTAssertNil(bruteForce, "BruteForce instance should not be created with missing or invalid input")
    }

    func testBruteForceInitializationWithPartialInput() {
        // Partial bruteforce capabilities
        let capabilities: [String: Any] = [
            "bruteforce": [
                // Only providing part of the required properties
                "delay": 10
            ]
        ]

        let bruteForce = BruteForce(capabilities: capabilities)
        XCTAssertNotNil(bruteForce, "BruteForce instance should be created with partial input")
        XCTAssertEqual(bruteForce?.delay, 10, "BruteForce delay should match the provided value with partial input")
        XCTAssertFalse(bruteForce?.allowListed ?? true, "BruteForce allowListed should default to false with partial input")
    }
}
