//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

///
/// Data model for a context menu item.
///
public struct ClientIntegrationContextMenuItem: Equatable, Sendable {
    ///
    /// A list of filters for MIME types.
    ///
    public let filters: [String]

    ///
    /// An absolute path for an image to display in the context menu.
    ///
    public let icon: String

    ///
    /// The HTTP verb to use when opening the ``path``.
    ///
    public let method: String

    ///
    /// The user-visible label for the context menu item.
    ///
    public let name: String

    ///
    /// Query parameters for the URL to open.
    ///
    /// Values might contain placeholders which must be substituted by the client.
    ///
    public let parameters: [String: String]

    ///
    /// The server address to open when this item is invoked.
    ///
    /// This is an absolute path on the server and not a fully qualified URL.
    ///
    public let path: String

    init?(data: [String: Any]) {
        // filters

        guard let filters = data["mimetype_filters"] as? String else {
            return nil
        }

        self.filters = filters.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }

        // icon

        guard let icon = data["icon"] as? String else {
            return nil
        }

        self.icon = icon

        // method

        guard let method = data["method"] as? String else {
            return nil
        }

        self.method = method

        // name

        guard let name = data["name"] as? String else {
            return nil
        }

        self.name = name

        // parameters

        if let params = data["params"] as? [String: String] {
            parameters = params
        } else {
            parameters = [:]
        }

        // path

        guard let path = data["url"] as? String else {
            return nil
        }

        self.path = path
    }
}
