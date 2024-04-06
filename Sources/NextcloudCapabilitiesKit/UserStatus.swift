//
//  UserStatus.swift
//
//
//  Created by Claudio Cambra on 6/4/24.
//

import Foundation

public struct UserStatus {
    let enabled: Bool
    let restore: Bool
    let supportsEmoji: Bool

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["user_status"] as? [String : Any] else {
            debugPrint("No user status data in received capabilities.")
            return nil
        }

        enabled = capabilities["enabled"] as? Bool ?? false
        restore = capabilities["restore"] as? Bool ?? false
        supportsEmoji = capabilities["supports_emoji"] as? Bool ?? false
    }
}
