//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: GPL-3.0-or-later

import Foundation

struct SpreedAttachments: Equatable {
    let allowed: Bool
    let folder: String

    init?(spreedConfigCapabilities: [String: Any]) {
        guard let spreedAttchCaps = spreedConfigCapabilities["attachments"] as? [String: Any] else {
            debugPrint("No attachment capabilities in spreed config capabilities")
            return nil
        }

        allowed = spreedAttchCaps["allowed"] as? Bool ?? false
        folder = spreedAttchCaps["folder"] as? String ?? ""
    }
}
