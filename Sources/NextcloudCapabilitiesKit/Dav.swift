//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Dav: Equatable {
    let chunking: String
    let bulkUpload: String

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["dav"] as? [String: Any] else {
            debugPrint("No dav data in received capabilities.")
            return nil
        }

        chunking = capabilities["chunking"] as? String ?? ""
        bulkUpload = capabilities["bulkupload"] as? String ?? ""
    }
}
