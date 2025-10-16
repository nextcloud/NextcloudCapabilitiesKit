//
//  SpreedSignalingTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

@testable import NextcloudCapabilitiesKit
import XCTest

class SpreedSignalingTests: XCTestCase {
    func testSpreedSignalingInitializationWithValidCapabilities() {
        // Valid spreed signaling capabilities
        let validCapabilities: [String: Any] = [
            "signaling": [
                "session-ping-limit": 60,
                "hello-v2-token-key": "testToken",
            ],
        ]

        let spreedSignaling = SpreedSignaling(spreedConfigCapabilities: validCapabilities)
        XCTAssertNotNil(spreedSignaling, "SpreedSignaling instance should be created with valid input")
        XCTAssertEqual(spreedSignaling?.sessionPingLimit, 60, "SpreedSignaling sessionPingLimit should match the provided value")
        XCTAssertEqual(spreedSignaling?.helloV2TokenKey, "testToken", "SpreedSignaling helloV2TokenKey should match the provided value")
    }

    func testSpreedSignalingInitializationWithInvalidCapabilities() {
        // Missing or invalid spreed signaling capabilities
        let invalidCapabilities: [String: Any] = [:]
        let spreedSignaling = SpreedSignaling(spreedConfigCapabilities: invalidCapabilities)
        XCTAssertNil(spreedSignaling, "SpreedSignaling instance should not be created with missing or invalid input")
    }

    func testSpreedSignalingInitializationWithPartialInput() {
        // Partial spreed signaling capabilities
        let partialCapabilities: [String: Any] = [
            "signaling": [
                "session-ping-limit": 30,
            ],
        ]

        let spreedSignaling = SpreedSignaling(spreedConfigCapabilities: partialCapabilities)
        XCTAssertNotNil(spreedSignaling, "SpreedSignaling instance should be created with partial input")
        XCTAssertEqual(spreedSignaling?.sessionPingLimit, 30, "SpreedSignaling sessionPingLimit should match the provided value with partial input")
        XCTAssertEqual(spreedSignaling?.helloV2TokenKey, "", "SpreedSignaling helloV2TokenKey should default to empty string with partial input")
    }
}
