//
//  SpreedAttachments.swift
//
//
//  Created by Claudio Cambra on 7/4/24.
//

import Foundation

struct SpreedAttachments {
    let allowed: Bool
    let folder: String

    init?(spreedConfigCapabilities: [String: Any]) {
        guard let spreedAttchCaps = spreedConfigCapabilities["attachments"] as? [String: Any] else {
            debugPrint("No attachment capabilities in spreed config capabilities")
            return nil
        }

        allowed = spreedAttchCaps["allowed"] as? Bool ?? false
        folder = spreedAttchCaps["folder"] as? String ?? ""
    }
}
