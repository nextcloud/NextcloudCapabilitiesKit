//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct PublicLink: Equatable, Sendable {
    public let enabled: Bool
    public let allowUpload: Bool
    public let supportsUploadOnly: Bool
    public let sendMail: Bool
    public let customTokens: Bool
    public let askOptionalPassword: Bool
    public let passwordEnforced: Bool
    public let expireDateEnabled: Bool
    public let expireDateEnforced: Bool
    public let expireDateDays: Int
    public let internalExpireDateEnabled: Bool
    public let internalExpireDateEnforced: Bool
    public let internalExpireDateDays: Int
    public let remoteExpireDateEnabled: Bool
    public let remoteExpireDateEnforced: Bool
    public let remoteExpireDateDays: Int
    public let multipleAllowed: Bool

    init?(filesSharingCapabilities: [String: Any]) {
        guard let publicLinkCaps = filesSharingCapabilities["public"] as? [String: Any] else {
            debugPrint("No public link data in received files sharingcapabilities.")
            return nil
        }

        enabled = publicLinkCaps["enabled"] as? Bool ?? false
        allowUpload = publicLinkCaps["upload"] as? Bool ?? false
        supportsUploadOnly = publicLinkCaps["upload_files_drop"] as? Bool
            ?? publicLinkCaps["supports_upload_only"] as? Bool
            ?? false
        sendMail = publicLinkCaps["send_mail"] as? Bool ?? false
        customTokens = publicLinkCaps["custom_tokens"] as? Bool ?? false
        multipleAllowed = publicLinkCaps["multiple_links"] as? Bool
            ?? publicLinkCaps["multiple"] as? Bool
            ?? false

        if let passwordCaps = publicLinkCaps["password"] as? [String: Any] {
            askOptionalPassword = passwordCaps["askForOptionalPassword"] as? Bool ?? false
            passwordEnforced = passwordCaps["enforced"] as? Bool ?? false
        } else {
            askOptionalPassword = false
            passwordEnforced = false
        }

        if let expireDateCapabilities = publicLinkCaps["expire_date"] as? [String: Any] {
            expireDateEnabled = expireDateCapabilities["enabled"] as? Bool ?? false
            expireDateDays = expireDateCapabilities["days"] as? Int ?? 1
            expireDateEnforced = expireDateCapabilities["enforced"] as? Bool ?? false
        } else {
            expireDateEnabled = false
            expireDateDays = 1
            expireDateEnforced = false
        }

        if let internalExpDateCaps = publicLinkCaps["expire_date_internal"] as? [String: Any] {
            internalExpireDateEnabled = internalExpDateCaps["enabled"] as? Bool ?? false
            internalExpireDateDays = internalExpDateCaps["days"] as? Int ?? 1
            internalExpireDateEnforced = internalExpDateCaps["enforced"] as? Bool ?? false
        } else {
            internalExpireDateEnabled = false
            internalExpireDateDays = 1
            internalExpireDateEnforced = false
        }

        if let remoteExpDateCaps = publicLinkCaps["expire_date_remote"] as? [String: Any] {
            remoteExpireDateEnabled = remoteExpDateCaps["enabled"] as? Bool ?? false
            remoteExpireDateDays = remoteExpDateCaps["days"] as? Int ?? 1
            remoteExpireDateEnforced = remoteExpDateCaps["enforced"] as? Bool ?? false
        } else {
            remoteExpireDateEnabled = false
            remoteExpireDateDays = 1
            remoteExpireDateEnforced = false
        }
    }
}
