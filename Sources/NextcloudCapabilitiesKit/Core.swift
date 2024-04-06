//
//  Core.swift
//
//
//  Created by Claudio Cambra on 6/4/24.
//

import Foundation

public struct Core {
    let pollInterval: Int
    let webdavRoot: String
    let referenceApi: Bool
    let referenceRegex: String

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["core"] as? [String : Any] else {
            debugPrint("No core data in received capabilities.")
            return nil
        }

        pollInterval = capabilities["pollinterval"] as? Int ?? 60
        webdavRoot = capabilities["webdav-root"] as? String ?? "remote.php/webdav"
        referenceApi = capabilities["reference-api"] as? Bool ?? false
        referenceRegex = capabilities["reference-regex"] as? String ?? ""
    }
}
