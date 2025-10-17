//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Spreed: Equatable, Sendable {
    let config: SpreedConfig?
    let features: [String]
    let version: String

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["spreed"] as? [String: Any] else {
            debugPrint("No spreed data in received capabilities.")
            return nil
        }

        config = SpreedConfig(spreedCapabilities: capabilities)
        features = capabilities["features"] as? [String] ?? []
        version = capabilities["version"] as? String ?? ""
    }
}
