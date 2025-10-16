//
//  EndpointsTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest

@testable import NextcloudCapabilitiesKit

class EndpointsTests: XCTestCase {
    func testValidEndpointsInitialization() {
        // Valid endpoint capabilities
        let validCapabilities: [String: Any] = [
            "endpoints": [
                "websocket": "ws://example.com/websocket",
            ],
        ]

        let endpoints = Endpoints(notifyPushCapabilities: validCapabilities)
        XCTAssertNotNil(endpoints, "Endpoints instance should be created with valid input")
        XCTAssertEqual(endpoints?.websocket, "ws://example.com/websocket", "Websocket URL should match the provided value")
    }

    func testInvalidEndpointsInitialization() {
        // Missing endpoints capabilities
        let invalidCapabilities: [String: Any] = [:]
        let endpoints = Endpoints(notifyPushCapabilities: invalidCapabilities)
        XCTAssertNil(endpoints, "Endpoints instance should not be created with invalid input")
    }

    func testPartiallyValidEndpointsInitialization() {
        // Partially valid endpoint capabilities with some values missing
        let partialCapabilities: [String: Any] = [
            "endpoints": [:],
        ]

        let endpoints = Endpoints(notifyPushCapabilities: partialCapabilities)
        XCTAssertNotNil(endpoints, "Endpoints instance should be created even with partially valid input")
        XCTAssertNil(endpoints?.websocket, "Websocket URL should be nil when not provided")
    }
}
