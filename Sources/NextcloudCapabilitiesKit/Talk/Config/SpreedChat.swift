//
//  SpreedChat.swift
//  
//
//  Created by Claudio Cambra on 7/4/24.
//

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
