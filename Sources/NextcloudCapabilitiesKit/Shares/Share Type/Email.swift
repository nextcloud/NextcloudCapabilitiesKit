//
//  Email.swift
//
//
//  Created by Claudio Cambra on 20/3/24.
//

import Foundation

public struct Email: Equatable {
    public let passwordEnabled: Bool
    public let passwordEnforced: Bool

    init?(filesSharingCapabilities: [String: Any]) {
        guard let emailCaps = filesSharingCapabilities["sharebymail"] as? [String: Any] else {
            debugPrint("No email data in received files sharingcapabilities.")
            return nil
        }

        if let passwordCapabilities = emailCaps["password"] as? [String: Any] {
            passwordEnabled = passwordCapabilities["enabled"] as? Bool ?? false
            passwordEnforced = passwordCapabilities["enforced"] as? Bool ?? false
        } else {
            passwordEnabled = false
            passwordEnforced = false
        }
    }
}
