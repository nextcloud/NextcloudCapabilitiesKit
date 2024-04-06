//
//  SpreedConfig.swift
//
//
//  Created by Claudio Cambra on 7/4/24.
//

import Foundation

struct SpreedConfig {
    let attachments: SpreedAttachments?
    let call: SpreedCall?
    let chat: SpreedChat?
    let signaling: SpreedSignaling?
    let canCreateConversations: Bool
    let previewsMaxGifSize: Int

    init?(spreedCapabilities: [String: Any]) {
        guard let spreedConfigCapabilities = spreedCapabilities["config"] as? [String : Any] else {
            debugPrint("No config data in received spreed capabilities.")
            return nil
        }

        attachments = SpreedAttachments(spreedConfigCapabilities: spreedConfigCapabilities)
        call = SpreedCall(spreedConfigCapabilities: spreedConfigCapabilities)
        chat = SpreedChat(spreedConfigCapabilities: spreedConfigCapabilities)
        signaling = SpreedSignaling(spreedConfigCapabilities: spreedConfigCapabilities)

        if let conversationCaps = spreedConfigCapabilities["conversations"] as? [String: Any] {
            canCreateConversations = conversationCaps["can-create"] as? Bool ?? false
        } else {
            canCreateConversations = false
        }

        if let previewsCaps = spreedConfigCapabilities["previews"] as? [String: Any] {
            previewsMaxGifSize = previewsCaps["max-gif-size"] as? Int ?? 0
        } else {
            previewsMaxGifSize = 0
        }
    }
}
