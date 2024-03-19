//
//  FilesSharing.swift
//
//
//  Created by Claudio Cambra on 20/3/24.
//

import Foundation

public struct FilesSharing {
    public let email: Email
    public let apiEnabled: Bool
    public let resharing: Bool
    public let defaultPermissions: Int

    init() {
        email = Email()
        apiEnabled = false
        resharing = false
        defaultPermissions = 0
        debugPrint("Providing defaulted share capabilities!")
    }

    init(capabilities: [String: Any]) {
        guard let capabilities = capabilities["files_sharing"] as? [String : Any] else {
            debugPrint("No files sharing data in received capabilities.")
            email = Email()
            apiEnabled = false
            resharing = false
            defaultPermissions = 0
            return
        }

        email = Email(filesSharingCapabilities: capabilities)
        apiEnabled = capabilities["api_enabled"] as? Bool ?? false
        resharing = capabilities["resharing"] as? Bool ?? false
        defaultPermissions = capabilities["default_permissions"] as? Int ?? 0
        debugPrint("Parsed share capabilities.")
    }
}
