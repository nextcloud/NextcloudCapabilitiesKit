//  SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct SharingSourceType: Equatable, Sendable {
    public let className: String

    init?(capabilities: [String: Any]) {
        guard let className = capabilities["class"] as? String else {
            return nil
        }

        self.className = className
    }
}
