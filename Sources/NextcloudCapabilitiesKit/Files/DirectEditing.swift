//
//  DirectEditing.swift
//
//
//  Created by Claudio Cambra on 6/4/24.
//

import Foundation

struct DirectEditing {
    public let url: URL?
    public let etag: String
    public let supportsFileId: Bool

    init?(filesCapabilities: [String: Any]) {
        guard let capabilities = filesCapabilities["directEditing"] as? [String : Any] else {
            debugPrint("No direct editing data in received capabilities.")
            return nil
        }

        url = URL(string: (capabilities["url"] as? String ?? ""))
        etag = capabilities["etag"] as? String ?? ""
        supportsFileId = capabilities["supportsFileId"] as? Bool ?? false
    }
}
