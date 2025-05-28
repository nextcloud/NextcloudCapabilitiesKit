//
//  Group.swift
//
//
//  Created by Claudio Cambra on 6/4/24.
//

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
