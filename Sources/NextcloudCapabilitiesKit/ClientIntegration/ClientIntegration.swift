//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

///
/// The capability of client integration.
///
/// The presence of this capability indicates that clients can offer file context menu actions defined by and run on the server.
///
public struct ClientIntegration: Equatable, Sendable {
    ///
    /// Server apps and what context menu items they offer.
    ///
    public let apps: [ClientIntegrationApp]

    ///
    /// Try to parse the server response for client integration capabilities.
    ///
    /// - Parameters:
    ///     - capabilities: The `capabilities` dictionary as returned in the JSON from the server.
    ///
    /// - Returns: `nil`, if the parsing failed.
    ///
    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["client_integration"] as? [String: Any] else {
            debugPrint("No client_integration data in received capabilities.")
            return nil
        }

        var apps = [ClientIntegrationApp]()

        for key in capabilities.keys.sorted() {
            guard let data = capabilities[key] as? [String: Any] else {
                continue
            }

            if let app = ClientIntegrationApp(app: key, data: data) {
                apps.append(app)
            }
        }

        self.apps = apps
    }
}
