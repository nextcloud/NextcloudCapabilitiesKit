//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

@testable import NextcloudCapabilitiesKit
import Testing

@Suite("Client Integration Tests")
struct ClientIntegrationTests {
    @Test func decode() throws {
        let capabilities: [String: Any] = [
            "client_integration": [
                "some-server-app": [
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
            ]
        ]

        let result = ClientIntegration(capabilities: capabilities)
        #expect(result != nil)

        let item = try #require(result)
        #expect(item.apps.count == 1)
    }
}
