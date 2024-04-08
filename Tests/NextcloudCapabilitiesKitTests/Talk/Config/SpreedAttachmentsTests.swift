//
//  SpreedAttachmentsTests.swift
//  
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest
@testable import NextcloudCapabilitiesKit

class SpreedAttachmentsTests: XCTestCase {

    func testSpreedAttachmentsInitializationWithValidCapabilities() {
        // Valid spreed attachment capabilities
        let validCapabilities: [String: Any] = [
            "attachments": [
                "allowed": true,
                "folder": "uploads"
            ]
        ]

        let spreedAttachments = SpreedAttachments(spreedConfigCapabilities: validCapabilities)

        XCTAssertNotNil(spreedAttachments, "SpreedAttachments instance should be created with valid input")
        XCTAssertTrue(spreedAttachments?.allowed ?? false, "SpreedAttachments allowed should be true")
        XCTAssertEqual(spreedAttachments?.folder, "uploads", "SpreedAttachments folder should match the provided value")
    }

    func testSpreedAttachmentsInitializationWithPartialCapabilities() {
        // Partial spreed attachment capabilities
        let partialCapabilities: [String: Any] = [
            "attachments": [
                "allowed": true
            ]
        ]

        let spreedAttachments = SpreedAttachments(spreedConfigCapabilities: partialCapabilities)

        XCTAssertNotNil(spreedAttachments, "SpreedAttachments instance should be created with partial input")
        XCTAssertTrue(spreedAttachments?.allowed ?? false, "SpreedAttachments allowed should be true with partial input")
        XCTAssertEqual(spreedAttachments?.folder, "", "SpreedAttachments folder should be empty with partial input")
    }

    func testSpreedAttachmentsInitializationWithInvalidCapabilities() {
        // Missing or invalid spreed attachment capabilities
        let invalidCapabilities: [String: Any] = [:]
        let spreedAttachments = SpreedAttachments(spreedConfigCapabilities: invalidCapabilities)
        XCTAssertNil(spreedAttachments, "SpreedAttachments instance should not be created with missing or invalid input")
    }
}
