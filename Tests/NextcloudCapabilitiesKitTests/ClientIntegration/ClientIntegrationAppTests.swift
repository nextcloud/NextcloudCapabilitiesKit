//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import Testing

@Suite("Client Integration App Tests")
struct ClientIntegrationAppTests {
    @Test("Decode with double version")
    func decodeWithDoubleVersion() throws {
        let data: [String: Any] = [
            "version": 1.2,
            "context-menu": [
                [
                    "icon": "/apps/assistant/img/client_integration/summarize.svg",
                    "method": "POST",
                    "mimetype_filters": "text/, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/vnd.oasis.opendocument.text, application/pdf",
                    "name": "Summarize using AI",
                    "url": "/ocs/v2.php/apps/assistant/api/v1/file-action/{fileId}/core:text2text:summary"
                ]
            ]
        ]

        let result = ClientIntegrationApp(app: "example", data: data)
        #expect(result != nil)

        let app = try #require(result)

        // Verify identifier
        #expect(app.identifier == "example")

        // Verify version
        #expect(app.version == 1.2)
    }

    @Test("Decode with integer version")
    func decodeWithIntegerVersion() throws {
        let data: [String: Any] = [
            "version": 2,
            "context-menu": []
        ]

        let result = ClientIntegrationApp(app: "test-app", data: data)
        #expect(result != nil)

        let app = try #require(result)

        // Verify integer version is converted to double
        #expect(app.version == 2.0)
        #expect(app.identifier == "test-app")
        #expect(app.contextMenuItems.isEmpty)
    }

    // MARK: - Negative Tests

    @Test("Decode fails with missing version")
    func decodeFailsWithMissingVersion() {
        let data: [String: Any] = [
            "context-menu": []
        ]

        let result = ClientIntegrationApp(app: "no-version", data: data)
        #expect(result == nil)
    }

    @Test("Decode fails with invalid version type")
    func decodeFailsWithInvalidVersionType() {
        let data: [String: Any] = [
            "version": "1.2.3",
            "context-menu": []
        ]

        let result = ClientIntegrationApp(app: "invalid-version", data: data)
        #expect(result == nil)
    }

    @Test("Decode fails with missing context-menu")
    func decodeFailsWithMissingContextMenu() {
        let data: [String: Any] = [
            "version": 1.0
        ]

        let result = ClientIntegrationApp(app: "no-context-menu", data: data)
        #expect(result == nil)
    }

    @Test("Decode fails with invalid context-menu type")
    func decodeFailsWithInvalidContextMenuType() {
        let data: [String: Any] = [
            "version": 1.0,
            "context-menu": "not an array"
        ]

        let result = ClientIntegrationApp(app: "invalid-context-menu", data: data)
        #expect(result == nil)
    }
}
