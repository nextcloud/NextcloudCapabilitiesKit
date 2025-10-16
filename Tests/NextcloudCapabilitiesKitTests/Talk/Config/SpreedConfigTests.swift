//
//  SpreedConfigTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

@testable import NextcloudCapabilitiesKit
import XCTest

class SpreedConfigTests: XCTestCase {
    func testSpreedConfigInitializationWithValidCapabilities() {
        // Valid spreed config capabilities
        let spreedCapabilities: [String: Any] = [
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
        ]

        let spreedConfig = SpreedConfig(spreedCapabilities: spreedCapabilities)

        XCTAssertNotNil(spreedConfig, "SpreedConfig instance should be created with valid input")
        XCTAssertNotNil(spreedConfig?.attachments, "SpreedConfig attachments should not be nil")
        XCTAssertNotNil(spreedConfig?.call, "SpreedConfig call should not be nil")
        XCTAssertNotNil(spreedConfig?.chat, "SpreedConfig chat should not be nil")
        XCTAssertNotNil(spreedConfig?.signaling, "SpreedConfig signaling should not be nil")
        XCTAssertTrue(spreedConfig?.canCreateConversations ?? false, "SpreedConfig canCreateConversations should be true")
        XCTAssertEqual(spreedConfig?.previewsMaxGifSize, 1024, "SpreedConfig previewsMaxGifSize should match the provided value")
    }

    func testSpreedConfigInitializationWithInvalidCapabilities() {
        // Missing or invalid spreed config capabilities
        let invalidCapabilities: [String: Any] = [:]
        let spreedConfig = SpreedConfig(spreedCapabilities: invalidCapabilities)
        XCTAssertNil(spreedConfig, "SpreedConfig instance should not be created with missing or invalid input")
    }

    func testSpreedConfigInitializationWithPartialInput() {
        // Partial spreed config capabilities
        var spreedCapabilities: [String: Any] = [:]
        spreedCapabilities["config"] = [
            // Only providing part of the required properties
            "attachments": [
                "attachmentProperty": "value",
            ],
        ]

        let spreedConfig = SpreedConfig(spreedCapabilities: spreedCapabilities)
        XCTAssertNotNil(spreedConfig, "SpreedConfig instance should be created with partial input")
        XCTAssertNil(spreedConfig?.call, "SpreedConfig call should be nil with partial input")
        XCTAssertNil(spreedConfig?.signaling, "SpreedConfig signaling should be nil with partial input")
        XCTAssertFalse(spreedConfig?.canCreateConversations ?? true, "SpreedConfig canCreateConversations should be false with partial input")
        XCTAssertEqual(spreedConfig?.previewsMaxGifSize, 0, "SpreedConfig previewsMaxGifSize should default to 0 with partial input")
    }
}
