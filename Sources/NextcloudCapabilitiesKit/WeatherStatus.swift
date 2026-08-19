//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct WeatherStatus: Equatable, Sendable {
    public let enabled: Bool

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["weather_status"] as? [String: Any] else {
            debugPrint("No weather status data in received capabilities.")
            return nil
        }

        enabled = capabilities["enabled"] as? Bool ?? false
    }
}
