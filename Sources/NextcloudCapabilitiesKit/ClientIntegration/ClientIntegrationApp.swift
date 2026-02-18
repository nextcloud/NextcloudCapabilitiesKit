//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

///
/// Data model for a server app offering client integration.
///
public struct ClientIntegrationApp: Equatable, Sendable {
    ///
    /// The app identifier.
    ///
    public let identifier: String

    ///
    /// Context menu items offered by this app.
    ///
    public let contextMenuItems: [ClientIntegrationContextMenuItem]

    ///
    /// The server app version.
    ///
    public let version: Double

    init?(app: String, data: [String: Any]) {
        identifier = app

        let versionValue = data["version"]
        let parsedVersion: Double? = if let version = versionValue as? Double {
            version
        } else if let version = versionValue as? Int {
            Double(version)
        } else if let version = versionValue as? NSNumber {
            version.doubleValue
        } else {
            nil
        }

        guard let version = parsedVersion else {
            return nil
        }

        self.version = version

        guard let contextMenuItems = data["context-menu"] as? [[String: Any]] else {
            return nil
        }

        var items = [ClientIntegrationContextMenuItem]()

        for contextMenuItem in contextMenuItems {
            guard let item = ClientIntegrationContextMenuItem(data: contextMenuItem) else {
                continue
            }

            items.append(item)
        }

        self.contextMenuItems = items
    }
}
