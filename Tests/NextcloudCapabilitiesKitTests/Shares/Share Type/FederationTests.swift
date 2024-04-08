//
//  FederationTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest
@testable import NextcloudCapabilitiesKit

final class FederationTests: XCTestCase {

    func testFederationInitialization() {
        let filesSharingCapabilities: [String: Any] = [
            "federation": [
                "outgoing": true,
                "incoming": false,
                "expire_date": [
                    "enabled": true
                ],
                "expire_date_supported": [
                    "enabled": false
                ]
            ]
        ]

        let federation = Federation(filesSharingCapabilities: filesSharingCapabilities)

        XCTAssertNotNil(federation, "Federation instance should not be nil")
        XCTAssertEqual(federation?.outgoing, true, "Outgoing should be true")
        XCTAssertEqual(federation?.incoming, false, "Incoming should be false")
        XCTAssertEqual(federation?.expireDateEnabled, true, "ExpireDateEnabled should be true")
        XCTAssertEqual(federation?.expireDateSupported, false, "ExpireDateSupported should be false")
    }

    func testFederationInitializationWithMissingData() {
        let filesSharingCapabilities: [String: Any] = [:] // Missing "group" key
        let federation = Federation(filesSharingCapabilities: filesSharingCapabilities)
        XCTAssertNil(federation, "Federation initialization should fail with missing data")
    }
}
