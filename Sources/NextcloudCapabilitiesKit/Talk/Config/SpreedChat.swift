//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

struct SpreedChat: Equatable {
    let maxLength: Int
    let readPrivacy: Int
    let typingPrivacy: Int
    let translations: [String]

    init?(spreedConfigCapabilities: [String: Any]) {
        guard let spreedChatCaps = spreedConfigCapabilities["chat"] as? [String: Any] else {
            debugPrint("No chat capabilities in spreed config capabilities")
            return nil
        }

        maxLength = spreedChatCaps["max-length"] as? Int ?? 0
        readPrivacy = spreedChatCaps["read-privacy"] as? Int ?? 0
        typingPrivacy = spreedChatCaps["typing-privacy"] as? Int ?? 0
        translations = spreedChatCaps["translations"] as? [String] ?? []
    }
}
