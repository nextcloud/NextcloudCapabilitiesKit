//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct ProvisioningAPI: Equatable, Sendable {
    public let version: String
    public let accountPropertyScopesVersion: Int
    public let accountPropertyScopesFederatedEnabled: Bool
    public let accountPropertyScopesPublishedEnabled: Bool

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["provisioning_api"] as? [String: Any] else {
            debugPrint("No provisioning API data in received capabilities.")
            return nil
        }

        version = capabilities["version"] as? String ?? ""
        accountPropertyScopesVersion = capabilities["AccountPropertyScopesVersion"] as? Int ?? 0
        accountPropertyScopesFederatedEnabled = capabilities["AccountPropertyScopesFederatedEnabled"] as? Bool ?? false
        accountPropertyScopesPublishedEnabled = capabilities["AccountPropertyScopesPublishedEnabled"] as? Bool ?? false
    }
}
