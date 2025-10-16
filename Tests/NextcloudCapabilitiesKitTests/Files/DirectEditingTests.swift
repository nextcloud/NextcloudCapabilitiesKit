//
//  DirectEditingTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

@testable import NextcloudCapabilitiesKit
import XCTest

class DirectEditingTests: XCTestCase {
    func testValidDirectEditingInitialization() {
        // Valid direct editing capabilities
        let validCapabilities: [String: Any] = [
            "directEditing": [
                "url": "https://example.com/edit",
                "etag": "12345",
                "supportsFileId": true,
            ],
        ]

        let directEditing = DirectEditing(filesCapabilities: validCapabilities)

        XCTAssertNotNil(directEditing, "DirectEditing instance should be created with valid input")
        XCTAssertEqual(directEditing?.url, URL(string: "https://example.com/edit"), "URL should match the provided value")
        XCTAssertEqual(directEditing?.etag, "12345", "ETag should match the provided value")
        XCTAssertEqual(directEditing?.supportsFileId, true, "Supports File ID should match the provided value")
    }

    func testInvalidDirectEditingInitialization() {
        // Missing direct editing capabilities
        let invalidCapabilities: [String: Any] = [:]
        let directEditing = DirectEditing(filesCapabilities: invalidCapabilities)
        XCTAssertNil(directEditing, "DirectEditing instance should not be created with invalid input")
    }

    func testPartiallyValidDirectEditingInitialization() {
        // Partially valid direct editing capabilities with some values missing
        let partialCapabilities: [String: Any] = [
            "directEditing": [
                // Missing "url" and "etag" values
                "supportsFileId": true,
            ],
        ]

        let directEditing = DirectEditing(filesCapabilities: partialCapabilities)

        XCTAssertNotNil(directEditing, "DirectEditing instance should be created even with partially valid input")
        XCTAssertNil(directEditing?.url, "URL should be nil when not provided")
        XCTAssertEqual(directEditing?.etag, "", "ETag should default to an empty string")
        XCTAssertEqual(directEditing?.supportsFileId, true, "Supports File ID should match the provided value")
    }
}
