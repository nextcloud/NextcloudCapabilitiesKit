//
//  EmailTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

@testable import NextcloudCapabilitiesKit
import XCTest

final class EmailTests: XCTestCase {
    func testEmailInitializationWithValidData() {
        // Prepare test data
        let filesSharingCapabilities: [String: Any] = [
            "sharebymail": [
                "password": [
                    "enabled": true,
                    "enforced": false,
                ],
            ],
        ]

        let email = Email(filesSharingCapabilities: filesSharingCapabilities)
        XCTAssertNotNil(email)
        XCTAssertEqual(email?.passwordEnabled, true)
        XCTAssertEqual(email?.passwordEnforced, false)
    }

    func testEmailInitializationWithMissingData() {
        let filesSharingCapabilities: [String: Any] = [:]
        let email = Email(filesSharingCapabilities: filesSharingCapabilities)
        XCTAssertNil(email)
    }
}
