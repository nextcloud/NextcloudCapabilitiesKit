//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Endpoints: Equatable {
    public let websocket: String?

    init?(notifyPushCapabilities: [String: Any]) {
        guard let endpointCaps = notifyPushCapabilities["endpoints"] as? [String: Any] else {
            debugPrint("No endpoints data in received capabilities.")
            return nil
        }

        websocket = endpointCaps["websocket"] as? String
    }
}
