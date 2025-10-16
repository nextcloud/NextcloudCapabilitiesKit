//
//  SpreedCallTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest

@testable import NextcloudCapabilitiesKit

class SpreedCallTests: XCTestCase {
    func testSpreedCallInitializationWithValidCapabilities() {
        // Valid spreed call capabilities
        let validCapabilities: [String: Any] = [
            "call": [
                "enabled": true,
                "breakout-rooms": false,
                "recording": true,
                "can-upload-background": true,
                "supported-reactions": ["like", "love"],
                "predefined-backgrounds": ["mountains", "beach"],
            ],
        ]

        let spreedCall = SpreedCall(spreedConfigCapabilities: validCapabilities)

        XCTAssertNotNil(spreedCall, "SpreedCall instance should be created with valid input")
        XCTAssertTrue(spreedCall?.enabled ?? false, "SpreedCall enabled should be true")
        XCTAssertFalse(spreedCall?.breakoutRooms ?? true, "SpreedCall breakoutRooms should be false")
        XCTAssertTrue(spreedCall?.recording ?? false, "SpreedCall recording should be true")
        XCTAssertTrue(spreedCall?.canUploadBackground ?? false, "SpreedCall canUploadBackground should be true")
        XCTAssertEqual(spreedCall?.supportedReactions, ["like", "love"], "SpreedCall supportedReactions should match the provided values")
        XCTAssertEqual(spreedCall?.predefinedBackgrounds, ["mountains", "beach"], "SpreedCall predefinedBackgrounds should match the provided values")
    }

    func testSpreedCallInitializationWithInvalidCapabilities() {
        // Missing or invalid spreed call capabilities
        let invalidCapabilities: [String: Any] = [:]
        let spreedCall = SpreedCall(spreedConfigCapabilities: invalidCapabilities)
        XCTAssertNil(spreedCall, "SpreedCall instance should not be created with missing or invalid input")
    }

    func testSpreedCallInitializationWithPartialInput() {
        // Partial spreed call capabilities
        let partialCapabilities: [String: Any] = [
            "call": [
                "enabled": true,
            ],
        ]

        let spreedCall = SpreedCall(spreedConfigCapabilities: partialCapabilities)
        XCTAssertNotNil(spreedCall, "SpreedCall instance should be created with partial input")
        XCTAssertTrue(spreedCall?.enabled ?? false, "SpreedCall enabled should be true with partial input")
        XCTAssertFalse(spreedCall?.breakoutRooms ?? true, "SpreedCall breakoutRooms should default to false with partial input")
        XCTAssertFalse(spreedCall?.recording ?? true, "SpreedCall recording should default to false with partial input")
        XCTAssertFalse(spreedCall?.canUploadBackground ?? true, "SpreedCall canUploadBackground should default to false with partial input")
        XCTAssertEqual(spreedCall?.supportedReactions, [], "SpreedCall supportedReactions should be empty with partial input")
        XCTAssertEqual(spreedCall?.predefinedBackgrounds, [], "SpreedCall predefinedBackgrounds should be empty with partial input")
    }
}
