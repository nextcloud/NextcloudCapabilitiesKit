//
//  PasswordPolicyTests.swift
//  
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest
@testable import NextcloudCapabilitiesKit

class PasswordPolicyTests: XCTestCase {

    func testPasswordPolicyInitializationWithValidCapabilities() {
        // Valid password policy capabilities
        let capabilities: [String: Any] = [
            "password_policy": [
                "minLength": 8,
                "enforceNonCommonPassword": true,
                "enforceNumericCharacters": true,
                "enforceSpecialCharacters": false,
                "enforceUpperLowerCase": true,
                "api": [
                    "generate": "https://example.com/generate",
                    "validate": "https://example.com/validate"
                ]
            ]
        ]

        let passwordPolicy = PasswordPolicy(capabilities: capabilities)
        XCTAssertNotNil(passwordPolicy, "PasswordPolicy instance should be created with valid input")
        XCTAssertEqual(passwordPolicy?.minLength, 8, "PasswordPolicy minLength should match the provided value")
        XCTAssertTrue(passwordPolicy?.enforceNonCommonPassword ?? false, "PasswordPolicy enforceNonCommonPassword should be true")
        XCTAssertTrue(passwordPolicy?.enforceNumericCharacters ?? false, "PasswordPolicy enforceNumericCharacters should be true")
        XCTAssertFalse(passwordPolicy?.enforceSpecialCharacters ?? true, "PasswordPolicy enforceSpecialCharacters should be false")
        XCTAssertTrue(passwordPolicy?.enforceUpperLowerCase ?? false, "PasswordPolicy enforceUpperLowerCase should be true")
        XCTAssertEqual(passwordPolicy?.apiGenerateUrl, URL(string: "https://example.com/generate"), "PasswordPolicy apiGenerateUrl should match the provided URL")
        XCTAssertEqual(passwordPolicy?.apiValidateUrl, URL(string: "https://example.com/validate"), "PasswordPolicy apiValidateUrl should match the provided URL")
    }

    func testPasswordPolicyInitializationWithMissingCapabilities() {
        // Missing password policy capabilities
        let invalidCapabilities: [String: Any] = [:]
        let passwordPolicy = PasswordPolicy(capabilities: invalidCapabilities)
        XCTAssertNil(passwordPolicy, "PasswordPolicy instance should not be created with missing input")
    }

    func testPasswordPolicyInitializationWithPartialInput() {
        // Partial password policy capabilities
        let capabilities: [String: Any] = [
            "password_policy": [
                // Only providing part of the required properties
                "minLength": 6,
                "enforceUpperLowerCase": false
            ]
        ]
        
        let passwordPolicy = PasswordPolicy(capabilities: capabilities)
        XCTAssertNotNil(passwordPolicy, "PasswordPolicy instance should be created with partial input")
        XCTAssertEqual(passwordPolicy?.minLength, 6, "PasswordPolicy minLength should match the provided value with partial input")
        XCTAssertFalse(passwordPolicy?.enforceUpperLowerCase ?? true, "PasswordPolicy enforceUpperLowerCase should be false with partial input")
        XCTAssertEqual(passwordPolicy?.apiGenerateUrl, nil, "PasswordPolicy apiGenerateUrl should default to nil with partial input")
        XCTAssertEqual(passwordPolicy?.apiValidateUrl, nil, "PasswordPolicy apiValidateUrl should default to nil with partial input")
    }
}
