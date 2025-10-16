//
//  SpreedTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

@testable import NextcloudCapabilitiesKit
import XCTest

class SpreedTests: XCTestCase {
    func testSpreedInitializationWithValidCapabilities() {
        // Valid spreed capabilities
        let capabilities: [String: Any] = [
            "spreed": [
                "config": [
                    "attachments": [
                        "allowed": true,
                        "folder": "uploads",
                    ],
                    "call": [
                        "enabled": true,
                        "breakout-rooms": false,
                        "recording": true,
                        "can-upload-background": true,
                        "supported-reactions": ["like", "love"],
                        "predefined-backgrounds": ["mountains", "beach"],
                    ],
                    "chat": [
                        "max-length": 100,
                        "read-privacy": 1,
                        "typing-privacy": 2,
                        "translations": ["en", "fr", "de"],
                    ],
                    "signaling": [
                        "session-ping-limit": 60,
                        "hello-v2-token-key": "testToken",
                    ],
                    "conversations": [
                        "can-create": true,
                    ],
                    "previews": [
                        "max-gif-size": 1024,
                    ],
                ],
                "features": ["feature1", "feature2"],
                "version": "1.0",
            ],
        ]

        let spreed = Spreed(capabilities: capabilities)
        XCTAssertNotNil(spreed, "Spreed instance should be created with valid input")
        XCTAssertNotNil(spreed?.config, "Spreed config should be initialized with valid capabilities")
        XCTAssertEqual(spreed?.features, ["feature1", "feature2"], "Spreed features should match the provided values")
        XCTAssertEqual(spreed?.version, "1.0", "Spreed version should match the provided value")
    }

    func testSpreedInitializationWithInvalidCapabilities() {
        // Missing or invalid spreed capabilities
        let invalidCapabilities: [String: Any] = [:]
        let spreed = Spreed(capabilities: invalidCapabilities)
        XCTAssertNil(spreed, "Spreed instance should not be created with missing or invalid input")
    }

    func testSpreedInitializationWithPartialInput() {
        // Partial spreed capabilities
        var capabilities: [String: Any] = [:]
        capabilities["spreed"] = [
            // Only providing part of the required properties
            "features": ["feature1", "feature2"],
        ]

        let spreed = Spreed(capabilities: capabilities)

        XCTAssertNotNil(spreed, "Spreed instance should be created with partial input")
        XCTAssertNil(spreed?.config, "Spreed config should be nil with partial input")
        XCTAssertEqual(spreed?.features, ["feature1", "feature2"], "Spreed features should match the provided values with partial input")
        XCTAssertEqual(spreed?.version, "", "Spreed version should default to empty string with partial input")
    }
}
