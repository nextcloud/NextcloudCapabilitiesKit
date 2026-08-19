//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Core: Equatable, Sendable {
    public let pollInterval: Int
    public let webdavRoot: String
    public let referenceApi: Bool
    public let referenceRegex: String
    public let modRewriteWorking: Bool
    public let user: CoreUser?
    public let canCreateAppToken: Bool?

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["core"] as? [String: Any] else {
            debugPrint("No core data in received capabilities.")
            return nil
        }

        pollInterval = capabilities["pollinterval"] as? Int ?? 60
        webdavRoot = capabilities["webdav-root"] as? String ?? "remote.php/webdav"
        referenceApi = capabilities["reference-api"] as? Bool ?? false
        referenceRegex = capabilities["reference-regex"] as? String ?? ""
        modRewriteWorking = capabilities["mod-rewrite-working"] as? Bool ?? false
        user = CoreUser(capabilities: capabilities["user"] as? [String: Any] ?? [:])
        canCreateAppToken = capabilities["can-create-app-token"] as? Bool
    }
}
