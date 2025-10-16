//
//  GroupTests.swift
//
//
//  Created by Claudio Cambra on 8/4/24.
//

@testable import NextcloudCapabilitiesKit
import XCTest

final class GroupTests: XCTestCase {
    func testGroupInitialization() {
        let filesSharingCapabilities: [String: Any] = [
            "group": [
                "enabled": true,
                "expire_date": [
                    "enabled": false,
                ],
            ],
        ]

        let group = Group(filesSharingCapabilities: filesSharingCapabilities)

        XCTAssertNotNil(group, "Group instance should not be nil")
        XCTAssertEqual(group?.enabled, true, "Enabled should be true")
        XCTAssertEqual(group?.expireDateEnabled, false, "ExpireDateEnabled should be false")
    }

    func testGroupInitializationWithMissingData() {
        let filesSharingCapabilities: [String: Any] = [:] // Missing "group" key
        let group = Group(filesSharingCapabilities: filesSharingCapabilities)
        XCTAssertNil(group, "Group initialization should fail with missing data")
    }
}
