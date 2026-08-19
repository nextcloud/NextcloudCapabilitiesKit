//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Sharee: Equatable, Sendable {
    public let minSearchStringLength: Int
    public let queryLookupDefault: Bool
    public let alwaysShowUnique: Bool

    init?(filesSharingCapabilities: [String: Any]) {
        guard let shareeCaps = filesSharingCapabilities["sharee"] as? [String: Any] else {
            debugPrint("No sharee data in received files sharingcapabilities.")
            return nil
        }

        minSearchStringLength = shareeCaps["minSearchStringLength"] as? Int ?? 0
        queryLookupDefault = shareeCaps["query_lookup_default"] as? Bool ?? false
        alwaysShowUnique = shareeCaps["always_show_unique"] as? Bool ?? false
    }
}
