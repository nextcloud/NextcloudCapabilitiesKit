//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

struct SpreedCall: Equatable {
    let enabled: Bool
    let breakoutRooms: Bool
    let recording: Bool
    let canUploadBackground: Bool
    let supportedReactions: [String]
    let predefinedBackgrounds: [String]

    init?(spreedConfigCapabilities: [String: Any]) {
        guard let spreedCallCaps = spreedConfigCapabilities["call"] as? [String: Any] else {
            debugPrint("No call capabilities in spreed config capabilities")
            return nil
        }

        enabled = spreedCallCaps["enabled"] as? Bool ?? false
        breakoutRooms = spreedCallCaps["breakout-rooms"] as? Bool ?? false
        recording = spreedCallCaps["recording"] as? Bool ?? false
        canUploadBackground = spreedCallCaps["can-upload-background"] as? Bool ?? false
        supportedReactions = spreedCallCaps["supported-reactions"] as? [String] ?? []
        predefinedBackgrounds = spreedCallCaps["predefined-backgrounds"] as? [String] ?? []
    }
}
