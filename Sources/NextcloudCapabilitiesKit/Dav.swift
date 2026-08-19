//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Dav: Equatable, Sendable {
    public let chunking: String
    public let publicSharesChunking: Bool
    public let searchSupportsCreationTime: Bool
    public let searchSupportsUploadTime: Bool
    public let searchSupportsLastActivity: Bool
    public let bulkUpload: String?
    public let absenceSupported: Bool
    public let absenceReplacement: Bool

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["dav"] as? [String: Any] else {
            debugPrint("No dav data in received capabilities.")
            return nil
        }

        chunking = capabilities["chunking"] as? String ?? ""
        publicSharesChunking = capabilities["public_shares_chunking"] as? Bool ?? false
        searchSupportsCreationTime = capabilities["search_supports_creation_time"] as? Bool ?? false
        searchSupportsUploadTime = capabilities["search_supports_upload_time"] as? Bool ?? false
        searchSupportsLastActivity = capabilities["search_supports_last_activity"] as? Bool ?? false
        bulkUpload = capabilities["bulkupload"] as? String
        absenceSupported = capabilities["absence-supported"] as? Bool ?? false
        absenceReplacement = capabilities["absence-replacement"] as? Bool ?? false
    }
}
