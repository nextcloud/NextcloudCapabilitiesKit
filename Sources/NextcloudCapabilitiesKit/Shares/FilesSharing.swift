//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct FilesSharing: Equatable {
    public let email: Email?
    public let publicLink: PublicLink?
    public let user: User?
    public let group: Group?
    public let federation: Federation?
    public let sharee: Sharee?
    public let apiEnabled: Bool
    public let resharing: Bool
    public let defaultPermissions: Int

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["files_sharing"] as? [String: Any] else {
            debugPrint("No files sharing data in received capabilities.")
            return nil
        }

        email = Email(filesSharingCapabilities: capabilities)
        publicLink = PublicLink(filesSharingCapabilities: capabilities)
        user = User(filesSharingCapabilities: capabilities)
        group = Group(filesSharingCapabilities: capabilities)
        federation = Federation(filesSharingCapabilities: capabilities)
        sharee = Sharee(filesSharingCapabilities: capabilities)
        apiEnabled = capabilities["api_enabled"] as? Bool ?? false
        resharing = capabilities["resharing"] as? Bool ?? false
        defaultPermissions = capabilities["default_permissions"] as? Int ?? 0
        debugPrint("Parsed share capabilities.")
    }
}
