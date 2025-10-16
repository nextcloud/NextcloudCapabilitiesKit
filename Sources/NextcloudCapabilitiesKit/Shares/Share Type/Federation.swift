//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: GPL-3.0-or-later

import Foundation

public struct Federation: Equatable {
    let outgoing: Bool
    let incoming: Bool
    let expireDateEnabled: Bool
    let expireDateSupported: Bool

    init?(filesSharingCapabilities: [String: Any]) {
        guard let federationCaps = filesSharingCapabilities["federation"] as? [String: Any] else {
            debugPrint("No federation data in received files sharingcapabilities.")
            return nil
        }

        outgoing = federationCaps["outgoing"] as? Bool ?? false
        incoming = federationCaps["incoming"] as? Bool ?? false

        if let expireDateCapabilities = federationCaps["expire_date"] as? [String: Any] {
            expireDateEnabled = expireDateCapabilities["enabled"] as? Bool ?? false
        } else {
            expireDateEnabled = false
        }
        if let expireDateSupportedCaps = federationCaps["expire_date_supported"] as? [String: Any] {
            expireDateSupported = expireDateSupportedCaps["enabled"] as? Bool ?? false
        } else {
            expireDateSupported = false
        }
    }
}
