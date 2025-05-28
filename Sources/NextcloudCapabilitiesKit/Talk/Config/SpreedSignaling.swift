//
//  SpreedSignalling.swift
//
//
//  Created by Claudio Cambra on 7/4/24.
//

import Foundation

struct SpreedSignaling: Equatable {
    let sessionPingLimit: Int
    let helloV2TokenKey: String

    init?(spreedConfigCapabilities: [String: Any]) {
        guard let spreedSignalCaps = spreedConfigCapabilities["signaling"] as? [String: Any] else {
            debugPrint("No signaling capabilities in spreed config capabilities")
            return nil
        }

        sessionPingLimit = spreedSignalCaps["session-ping-limit"] as? Int ?? 0
        helloV2TokenKey = spreedSignalCaps["hello-v2-token-key"] as? String ?? ""
    }
}
