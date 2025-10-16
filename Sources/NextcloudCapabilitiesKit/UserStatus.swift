//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct UserStatus: Equatable {
    let enabled: Bool
    let restore: Bool
    let supportsEmoji: Bool

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["user_status"] as? [String: Any] else {
            debugPrint("No user status data in received capabilities.")
            return nil
        }

        enabled = capabilities["enabled"] as? Bool ?? false
        restore = capabilities["restore"] as? Bool ?? false
        supportsEmoji = capabilities["supports_emoji"] as? Bool ?? false
    }
}
