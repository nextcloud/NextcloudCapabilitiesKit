//
//  SpreedChatTests.swift
//  
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest
@testable import NextcloudCapabilitiesKit

class SpreedChatTests: XCTestCase {

    func testSpreedChatInitializationWithValidCapabilities() {
        // Valid spreed chat capabilities
        let validCapabilities: [String: Any] = [
            "chat": [
                "max-length": 100,
                "read-privacy": 1,
                "typing-privacy": 2,
                "translations": ["en", "fr", "de"]
            ]
        ]

        let spreedChat = SpreedChat(spreedConfigCapabilities: validCapabilities)
        XCTAssertNotNil(spreedChat, "SpreedChat instance should be created with valid input")
        XCTAssertEqual(spreedChat?.maxLength, 100, "SpreedChat maxLength should match the provided value")
        XCTAssertEqual(spreedChat?.readPrivacy, 1, "SpreedChat readPrivacy should match the provided value")
        XCTAssertEqual(spreedChat?.typingPrivacy, 2, "SpreedChat typingPrivacy should match the provided value")
        XCTAssertEqual(spreedChat?.translations, ["en", "fr", "de"], "SpreedChat translations should match the provided values")
    }

    func testSpreedChatInitializationWithInvalidCapabilities() {
        // Missing or invalid spreed chat capabilities
        let invalidCapabilities: [String: Any] = [:]
        let spreedChat = SpreedChat(spreedConfigCapabilities: invalidCapabilities)
        XCTAssertNil(spreedChat, "SpreedChat instance should not be created with missing or invalid input")
    }

    func testSpreedChatInitializationWithPartialInput() {
        // Partial spreed chat capabilities
        let partialCapabilities: [String: Any] = [
            "chat": [
                "max-length": 150
            ]
        ]

        let spreedChat = SpreedChat(spreedConfigCapabilities: partialCapabilities)

        XCTAssertNotNil(spreedChat, "SpreedChat instance should be created with partial input")
        XCTAssertEqual(spreedChat?.maxLength, 150, "SpreedChat maxLength should match the provided value with partial input")
        XCTAssertEqual(spreedChat?.readPrivacy, 0, "SpreedChat readPrivacy should default to 0 with partial input")
        XCTAssertEqual(spreedChat?.typingPrivacy, 0, "SpreedChat typingPrivacy should default to 0 with partial input")
        XCTAssertEqual(spreedChat?.translations, [], "SpreedChat translations should be empty with partial input")
    }
}
