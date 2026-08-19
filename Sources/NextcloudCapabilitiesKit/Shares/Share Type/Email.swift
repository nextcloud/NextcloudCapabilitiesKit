//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Email: Equatable, Sendable {
    public let enabled: Bool
    public let sendsPasswordByEmail: Bool
    public let uploadFilesDropEnabled: Bool
    public let passwordEnabled: Bool
    public let passwordEnforced: Bool
    public let expireDateEnabled: Bool
    public let expireDateEnforced: Bool

    init?(filesSharingCapabilities: [String: Any]) {
        guard let emailCaps = filesSharingCapabilities["sharebymail"] as? [String: Any] else {
            debugPrint("No email data in received files sharingcapabilities.")
            return nil
        }

        enabled = emailCaps["enabled"] as? Bool ?? false
        sendsPasswordByEmail = emailCaps["send_password_by_mail"] as? Bool ?? false
        uploadFilesDropEnabled = (emailCaps["upload_files_drop"] as? [String: Any])?["enabled"] as? Bool ?? false

        if let passwordCapabilities = emailCaps["password"] as? [String: Any] {
            passwordEnabled = passwordCapabilities["enabled"] as? Bool ?? false
            passwordEnforced = passwordCapabilities["enforced"] as? Bool ?? false
        } else {
            passwordEnabled = false
            passwordEnforced = false
        }

        if let expireDateCapabilities = emailCaps["expire_date"] as? [String: Any] {
            expireDateEnabled = expireDateCapabilities["enabled"] as? Bool ?? false
            expireDateEnforced = expireDateCapabilities["enforced"] as? Bool ?? false
        } else {
            expireDateEnabled = false
            expireDateEnforced = false
        }
    }
}
