//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Files: Equatable, Sendable {
    public let bigFileChunking: Bool
    public let blackListedFiles: [String]
    public let forbiddenFilenames: [String]
    public let forbiddenFilenameBasenames: [String]
    public let forbiddenFilenameCharacters: [String]
    public let forbiddenFilenameExtensions: [String]
    public let fileConversions: [FileConversion]
    public let directEditing: DirectEditing?
    public let chunkedUpload: ChunkedUpload?
    public let comments: Bool
    public let undelete: Bool
    public let deleteFromTrash: Bool
    public let versioning: Bool
    public let versionLabeling: Bool
    public let versionDeletion: Bool
    public let locking: String?
    public let windowsCompatibleFilenames: Bool

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["files"] as? [String: Any] else {
            debugPrint("No files data in received capabilities.")
            return nil
        }

        bigFileChunking = capabilities["bigfilechunking"] as? Bool ?? false
        blackListedFiles = capabilities["blacklisted_files"] as? [String] ?? []
        forbiddenFilenames = capabilities["forbidden_filenames"] as? [String] ?? []
        forbiddenFilenameBasenames = capabilities["forbidden_filename_basenames"] as? [String] ?? []
        forbiddenFilenameCharacters = capabilities["forbidden_filename_characters"] as? [String] ?? []
        forbiddenFilenameExtensions = capabilities["forbidden_filename_extensions"] as? [String] ?? []
        fileConversions = (capabilities["file_conversions"] as? [[String: Any]] ?? []).compactMap(FileConversion.init)
        directEditing = DirectEditing(filesCapabilities: capabilities)
        chunkedUpload = ChunkedUpload(filesCapabilities: capabilities)
        comments = capabilities["comments"] as? Bool ?? false
        undelete = capabilities["undelete"] as? Bool ?? false
        deleteFromTrash = capabilities["delete_from_trash"] as? Bool ?? false
        versioning = capabilities["versioning"] as? Bool ?? false
        versionLabeling = capabilities["version_labeling"] as? Bool ?? false
        versionDeletion = capabilities["version_deletion"] as? Bool ?? false
        locking = capabilities["locking"] as? String ?? nil
        windowsCompatibleFilenames = capabilities["windows_compatible_filenames"] as? Bool ?? false
    }
}
