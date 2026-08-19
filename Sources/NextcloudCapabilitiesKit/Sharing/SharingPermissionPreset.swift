//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct SharingPermissionPreset: Equatable, Sendable {
    public let className: String
    public let displayName: String
    public let hint: String

    init?(capabilities: [String: Any]) {
        guard let className = capabilities["class"] as? String,
              let displayName = capabilities["display_name"] as? String,
              let hint = capabilities["hint"] as? String
        else {
            return nil
        }

        self.className = className
        self.displayName = displayName
        self.hint = hint
    }
}
