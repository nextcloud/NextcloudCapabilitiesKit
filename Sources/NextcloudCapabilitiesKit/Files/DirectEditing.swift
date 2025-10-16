//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct DirectEditing: Equatable {
    public let url: URL?
    public let etag: String
    public let supportsFileId: Bool

    init?(filesCapabilities: [String: Any]) {
        guard let capabilities = filesCapabilities["directEditing"] as? [String: Any] else {
            debugPrint("No direct editing data in received capabilities.")
            return nil
        }

        url = URL(string: (capabilities["url"] as? String ?? ""))
        etag = capabilities["etag"] as? String ?? ""
        supportsFileId = capabilities["supportsFileId"] as? Bool ?? false
    }
}
