//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct FileConversion: Equatable, Sendable {
    public let from: String
    public let to: String
    public let `extension`: String
    public let displayName: String

    init?(capabilities: [String: Any]) {
        guard let from = capabilities["from"] as? String,
              let to = capabilities["to"] as? String,
              let fileExtension = capabilities["extension"] as? String,
              let displayName = capabilities["displayName"] as? String
        else {
            return nil
        }

        self.from = from
        self.to = to
        `extension` = fileExtension
        self.displayName = displayName
    }
}
