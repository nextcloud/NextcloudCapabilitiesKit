//
//  Files.swift
//
//
//  Created by Claudio Cambra on 6/4/24.
//

import Foundation

public struct Files {
    public let bigFileChunking: Bool
    public let blackListedFiles: [String]
    public let directEditing: DirectEditing?
    public let chunkedUpload: ChunkedUpload?
    public let comments: Bool
    public let undelete: Bool
    public let versioning: Bool
    public let versionLabeling: Bool
    public let versionDeletion: Bool
    public let locking: String?

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
        locking = capabilities["locking"] as? String ?? nil
    }
}
