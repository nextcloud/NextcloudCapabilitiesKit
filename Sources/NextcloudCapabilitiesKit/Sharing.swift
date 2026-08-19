//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Sharing: Equatable, Sendable {
    public let apiVersions: [String]
    public let sourceTypes: [SharingSourceType]
    public let permissionPresets: [SharingPermissionPreset]

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["sharing"] as? [String: Any] else {
            debugPrint("No sharing data in received capabilities.")
            return nil
        }

        apiVersions = capabilities["api_versions"] as? [String] ?? []
        sourceTypes = (capabilities["source_types"] as? [[String: Any]] ?? []).compactMap(SharingSourceType.init)
        permissionPresets = (capabilities["permission_presets"] as? [[String: Any]] ?? []).compactMap(SharingPermissionPreset.init)
    }
}
