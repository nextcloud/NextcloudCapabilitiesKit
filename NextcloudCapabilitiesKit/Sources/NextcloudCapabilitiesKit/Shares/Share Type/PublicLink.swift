//
//  PublicLink.swift
//
//
//  Created by Claudio Cambra on 20/3/24.
//

import Foundation

public struct PublicLink {
    public let enabled: Bool
    public let allowUpload: Bool
    public let supportsUploadOnly: Bool
    public let askOptionalPassword: Bool
    public let passwordEnforced: Bool
    public let expireDateEnforced: Bool
    public let expireDateDays: Int
    public let internalExpireDateEnforced: Bool
    public let internalExpireDateDays: Int
    public let remoteExpireDateEnforced: Bool
    public let remoteExpireDateDays: Int
    public let multipleAllowed: Bool

    init() {
        enabled = false
        allowUpload = false
        supportsUploadOnly = false
        askOptionalPassword = false
        passwordEnforced = false
        expireDateEnforced = false
        expireDateDays = 1
        internalExpireDateEnforced = false
        internalExpireDateDays = 1
        remoteExpireDateEnforced = false
        remoteExpireDateDays = 1
        multipleAllowed = false
    }

    init(filesSharingCapabilities: [String: Any]) {
        guard let publicLinkCaps = filesSharingCapabilities["public"] as? [String: Any] else {
            debugPrint("No public link data in received files sharingcapabilities.")
            enabled = false
            allowUpload = false
            supportsUploadOnly = false
            askOptionalPassword = false
            passwordEnforced = false
            expireDateEnforced = false
            expireDateDays = 1
            internalExpireDateEnforced = false
            internalExpireDateDays = 1
            remoteExpireDateEnforced = false
            remoteExpireDateDays = 1
            multipleAllowed = false
            return
        }

        enabled = publicLinkCaps["enabled"] as? Bool ?? false
        allowUpload = publicLinkCaps["upload"] as? Bool ?? false
        supportsUploadOnly = publicLinkCaps["supports_upload_only"] as? Bool ?? false
        multipleAllowed = publicLinkCaps["multiple"] as? Bool ?? false

        if let passwordCaps = publicLinkCaps["password"] as? [String : Any] {
            askOptionalPassword = passwordCaps["askForOptionalPassword"] as? Bool ?? false
            passwordEnforced = passwordCaps["enforced"] as? Bool ?? false
        } else {
            askOptionalPassword = false
            passwordEnforced = false
        }

        if let expireDateCapabilities = publicLinkCaps["expire_date"] as? [String: Any] {
            expireDateDays = expireDateCapabilities["days"] as? Int ?? 1
            expireDateEnforced = expireDateCapabilities["enforced"] as? Bool ?? false
        } else {
            expireDateDays = 1
            expireDateEnforced = false
        }

        if let internalExpDateCaps = publicLinkCaps["expire_date_internal"] as? [String: Any] {
            internalExpireDateDays = internalExpDateCaps["days"] as? Int ?? 1
            internalExpireDateEnforced = internalExpDateCaps["enforced"] as? Bool ?? false
        } else {
            internalExpireDateDays = 1
            internalExpireDateEnforced = false
        }

        if let remoteExpDateCaps = publicLinkCaps["expire_date_remote"] as? [String: Any] {
            remoteExpireDateDays = remoteExpDateCaps["days"] as? Int ?? 1
            remoteExpireDateEnforced = remoteExpDateCaps["enforced"] as? Bool ?? false
        } else {
            remoteExpireDateDays = 1
            remoteExpireDateEnforced = false
        }
    }
}
