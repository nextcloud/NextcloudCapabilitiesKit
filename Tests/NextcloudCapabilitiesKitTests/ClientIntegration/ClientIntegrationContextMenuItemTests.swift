//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import Testing

@Suite("Client Integration Context Menu Item Tests")
struct ClientIntegrationContextMenuItemTests {
    @Test("Without Parameters")
    func decodeWithoutParameters() throws {
        let data: [String: Any] = [
            "icon": "/apps/assistant/img/client_integration/summarize.svg",
            "method": "POST",
            "mimetype_filters": "text/, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/vnd.oasis.opendocument.text, application/pdf",
            "name": "Summarize using AI",
            "url": "/ocs/v2.php/apps/assistant/api/v1/file-action/{fileId}/core:text2text:summary"
        ]

        let result = ClientIntegrationContextMenuItem(data: data)
        #expect(result != nil)

        let item = try #require(result)

        // Verify icon
        #expect(item.icon == "/apps/assistant/img/client_integration/summarize.svg")

        // Verify method
        #expect(item.method == "POST")

        // Verify name
        #expect(item.name == "Summarize using AI")

        // Verify path (decoded from "url" key)
        #expect(item.path == "/ocs/v2.php/apps/assistant/api/v1/file-action/{fileId}/core:text2text:summary")

        // Verify filters (parsed from comma-separated string)
        #expect(item.filters.count == 5)
        #expect(item.filters[0] == "text/")
        #expect(item.filters[1] == "application/msword")
        #expect(item.filters[2] == "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
        #expect(item.filters[3] == "application/vnd.oasis.opendocument.text")
        #expect(item.filters[4] == "application/pdf")

        // Verify parameters is empty when not provided
        #expect(item.parameters.isEmpty)
    }

    @Test("With Parameters")
    func decodeWithParameters() throws {
        let data: [String: Any] = [
            "icon": "/apps/assistant/img/client_integration/summarize.svg",
            "method": "POST",
            "mimetype_filters": "text/, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document, application/vnd.oasis.opendocument.text, application/pdf",
            "name": "Summarize using AI",
            "params": [
                "some": "parameter"
            ],
            "url": "/ocs/v2.php/apps/assistant/api/v1/file-action/{fileId}/core:text2text:summary"
        ]

        let result = ClientIntegrationContextMenuItem(data: data)
        #expect(result != nil)

        let item = try #require(result)

        // Verify icon
        #expect(item.icon == "/apps/assistant/img/client_integration/summarize.svg")

        // Verify method
        #expect(item.method == "POST")

        // Verify name
        #expect(item.name == "Summarize using AI")

        // Verify path (decoded from "url" key)
        #expect(item.path == "/ocs/v2.php/apps/assistant/api/v1/file-action/{fileId}/core:text2text:summary")

        // Verify filters (parsed from comma-separated string)
        #expect(item.filters.count == 5)
        #expect(item.filters[0] == "text/")
        #expect(item.filters[1] == "application/msword")
        #expect(item.filters[2] == "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
        #expect(item.filters[3] == "application/vnd.oasis.opendocument.text")
        #expect(item.filters[4] == "application/pdf")

        // Verify parameters
        #expect(item.parameters.count == 1)
        #expect(item.parameters["some"] == "parameter")
    }
}
