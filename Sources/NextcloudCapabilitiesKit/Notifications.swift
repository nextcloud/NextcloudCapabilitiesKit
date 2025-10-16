//
//  Notifications.swift
//
//
//  Created by Claudio Cambra on 7/4/24.
//

import Foundation

public struct Notifications: Equatable {
    let ocsEndpoints: [String]
    let push: [String]
    let adminNotifications: [String]

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["notifications"] as? [String: Any] else {
            debugPrint("No notifications data in received capabilities.")
            return nil
        }

        ocsEndpoints = capabilities["ocs-endpoints"] as? [String] ?? []
        push = capabilities["push"] as? [String] ?? []
        adminNotifications = capabilities["admin-notifications"] as? [String] ?? []
    }
}
