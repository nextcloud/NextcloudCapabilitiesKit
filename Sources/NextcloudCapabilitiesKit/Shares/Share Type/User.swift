//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct User: Equatable, Sendable {
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
