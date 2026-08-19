//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct CoreUser: Equatable, Sendable {
    public let language: String
    public let locale: String
    public let timeZone: String

    init?(capabilities: [String: Any]) {
        guard let language = capabilities["language"] as? String,
              let locale = capabilities["locale"] as? String,
              let timeZone = capabilities["timezone"] as? String
        else {
            return nil
        }

        self.language = language
        self.locale = locale
        self.timeZone = timeZone
    }
}
