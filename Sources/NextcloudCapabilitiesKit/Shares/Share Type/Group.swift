//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: GPL-3.0-or-later

import Foundation

public struct Group: Equatable {
    let enabled: Bool
    let expireDateEnabled: Bool

    init?(filesSharingCapabilities: [String: Any]) {
        guard let groupCaps = filesSharingCapabilities["group"] as? [String: Any] else {
            debugPrint("No group data in received files sharingcapabilities.")
            return nil
        }

        enabled = groupCaps["enabled"] as? Bool ?? false

        if let expireDateCapabilities = groupCaps["expire_date"] as? [String: Any] {
            expireDateEnabled = expireDateCapabilities["enabled"] as? Bool ?? false
        } else {
            expireDateEnabled = false
        }
    }
}
