//
//  ThemingTests.swift
//  
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest
@testable import NextcloudCapabilitiesKit

class ThemingTests: XCTestCase {

    func testThemingInitializationWithValidCapabilities() {
        // Valid theming capabilities
        let capabilities: [String: Any] = [
            "theming": [
                "name": "Theme Name",
                "url": "https://example.com",
                "slogan": "Theme Slogan",
                "color": "#FFFFFF",
                "color-text": "#000000",
                "color-element": "#FF0000",
                "color-element-bright": "#FFFF00",
                "color-element-dark": "#0000FF",
                "logo": "https://example.com/logo",
                "background": "#CCCCCC",
                "background-plain": true,
                "background-default": false,
                "logoheader": "https://example.com/logoheader",
                "favicon": "https://example.com/favicon"
            ]
        ]

        let theming = Theming(capabilities: capabilities)
        XCTAssertNotNil(theming, "Theming instance should be created with valid input")
        XCTAssertEqual(theming?.name, "Theme Name", "Theming name should match the provided value")
        XCTAssertEqual(theming?.url, URL(string: "https://example.com"), "Theming URL should match the provided URL")
        XCTAssertEqual(theming?.slogan, "Theme Slogan", "Theming slogan should match the provided value")
        XCTAssertEqual(theming?.color, "#FFFFFF", "Theming color should match the provided value")
        XCTAssertEqual(theming?.colorText, "#000000", "Theming colorText should match the provided value")
        XCTAssertEqual(theming?.colorElement, "#FF0000", "Theming colorElement should match the provided value")
        XCTAssertEqual(theming?.colorElementBright, "#FFFF00", "Theming colorElementBright should match the provided value")
        XCTAssertEqual(theming?.colorElementDark, "#0000FF", "Theming colorElementDark should match the provided value")
        XCTAssertEqual(theming?.logoUrl, URL(string: "https://example.com/logo"), "Theming logo URL should match the provided URL")
        XCTAssertEqual(theming?.backgroundColor, "#CCCCCC", "Theming backgroundColor should match the provided value")
        XCTAssertTrue(theming?.backgroundPlain ?? false, "Theming backgroundPlain should be true")
        XCTAssertFalse(theming?.backgroundDefault ?? true, "Theming backgroundDefault should be false")
        XCTAssertEqual(theming?.logoHeaderUrl, URL(string: "https://example.com/logoheader"), "Theming logoHeader URL should match the provided URL")
        XCTAssertEqual(theming?.faviconUrl, URL(string: "https://example.com/favicon"), "Theming favicon URL should match the provided URL")
    }

    func testThemingInitializationWithMissingCapabilities() {
        // Missing theming capabilities
        let invalidCapabilities: [String: Any] = [:]
        let theming = Theming(capabilities: invalidCapabilities)
        XCTAssertNil(theming, "Theming instance should not be created with missing input")
    }

    func testThemingInitializationWithPartialInput() {
        // Partial theming capabilities
        let capabilities: [String: Any] = [
            "theming": [
                // Only providing part of the required properties
                "name": "Partial Theme",
                "slogan": "Partial Slogan",
                "color": "#AAAAAA"
            ]
        ]

        let theming = Theming(capabilities: capabilities)

        XCTAssertNotNil(theming, "Theming instance should be created with partial input")
        XCTAssertEqual(theming?.name, "Partial Theme", "Theming name should match the provided value with partial input")
        XCTAssertEqual(theming?.slogan, "Partial Slogan", "Theming slogan should match the provided value with partial input")
        XCTAssertEqual(theming?.color, "#AAAAAA", "Theming color should match the provided value with partial input")
        XCTAssertEqual(theming?.url, nil, "Theming URL should default to nil with partial input")
        XCTAssertEqual(theming?.logoUrl, nil, "Theming logo URL should default to nil with partial input")
        XCTAssertEqual(theming?.backgroundColor, "", "Theming backgroundColor should default to an empty string with partial input")
    }
}
