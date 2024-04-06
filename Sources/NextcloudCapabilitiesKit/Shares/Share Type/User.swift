//
//  User.swift
//
//
//  Created by Claudio Cambra on 6/4/24.
//

import Foundation

public struct User {
    let sendMail: Bool
    let expireDateEnabled: Bool

    init?(filesSharingCapabilities: [String: Any]) {
        guard let userCaps = filesSharingCapabilities["user"] as? [String: Any] else {
            debugPrint("No user data in received files sharingcapabilities.")
            return nil
        }

        sendMail = userCaps["send_mail"] as? Bool ?? false

        if let expireDateCapabilities = userCaps["expire_date"] as? [String: Any] {
            expireDateEnabled = expireDateCapabilities["enabled"] as? Bool ?? false
        } else {
            expireDateEnabled = false
        }
    }
}
