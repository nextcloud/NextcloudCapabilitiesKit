//
//  Files.swift
//
//
//  Created by Claudio Cambra on 6/4/24.
//

import Foundation

public struct Files {
    let bigFileChunking: Bool
    let blackListedFiles: [String]
    let directEditing: DirectEditing?
    let chunkedUpload: ChunkedUpload?
    let comments: Bool
    let undelete: Bool
    let versioning: Bool
    let versionLabeling: Bool
    let versionDeletion: Bool

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["files"] as? [String : Any] else {
            debugPrint("No files data in received capabilities.")
            return nil
        }

        bigFileChunking = capabilities["bigfilechunking"] as? Bool ?? false
        blackListedFiles = capabilities["blacklisted_files"] as? [String] ?? []
        directEditing = DirectEditing(filesCapabilities: capabilities)
        chunkedUpload = ChunkedUpload(filesCapabilities: capabilities)
        comments = capabilities["comments"] as? Bool ?? false
        undelete = capabilities["undelete"] as? Bool ?? false
        versioning = capabilities["versioning"] as? Bool ?? false
        versionLabeling = capabilities["version_labeling"] as? Bool ?? false
        versionDeletion = capabilities["version_deletion"] as? Bool ?? false
    }
}
