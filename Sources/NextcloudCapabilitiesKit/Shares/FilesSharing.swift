//
//  FilesSharing.swift
//
//
//  Created by Claudio Cambra on 20/3/24.
//

import Foundation

public struct FilesSharing {
    public let email: Email?
    public let publicLink: PublicLink?
    public let apiEnabled: Bool
    public let resharing: Bool
    public let defaultPermissions: Int

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["files_sharing"] as? [String : Any] else {
            debugPrint("No files sharing data in received capabilities.")
            return nil
        }

        email = Email(filesSharingCapabilities: capabilities)
        publicLink = PublicLink(filesSharingCapabilities: capabilities)
        apiEnabled = capabilities["api_enabled"] as? Bool ?? false
        resharing = capabilities["resharing"] as? Bool ?? false
        defaultPermissions = capabilities["default_permissions"] as? Int ?? 0
        debugPrint("Parsed share capabilities.")
    }
}
