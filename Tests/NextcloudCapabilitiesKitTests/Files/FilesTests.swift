//
//  FilesTests.swift
//  
//
//  Created by Claudio Cambra on 8/4/24.
//

import XCTest

@testable import NextcloudCapabilitiesKit

class FilesTests: XCTestCase {

    func testValidFilesInitialization() {
        // Valid files capabilities
        let validCapabilities: [String: Any] = [
            "files": [
                "bigfilechunking": true,
                "blacklisted_files": ["file1", "file2"],
                "comments": false,
                "undelete": true,
                "versioning": false,
                "version_labeling": true,
                "version_deletion": false,
                "directEditing": [
                    "url": "https://example.com/edit",
                    "etag": "12345",
                    "supportsFileId": true
                ]
            ]
        ]

        let files = Files(capabilities: validCapabilities)

        XCTAssertNotNil(files, "Files instance should be created with valid input")
        XCTAssertEqual(files?.bigFileChunking, true, "Big File Chunking should be true")
        XCTAssertEqual(files?.blackListedFiles, ["file1", "file2"], "Blacklisted Files should match the provided values")
        XCTAssertNotNil(files?.directEditing, "Direct Editing should be initialized")
        XCTAssertEqual(files?.comments, false, "Comments should be false")
        XCTAssertEqual(files?.undelete, true, "Undelete should be true")
        XCTAssertEqual(files?.versioning, false, "Versioning should be false")
        XCTAssertEqual(files?.versionLabeling, true, "Version Labeling should be true")
        XCTAssertEqual(files?.versionDeletion, false, "Version Deletion should be false")
    }

    func testInvalidFilesInitialization() {
        // Missing files capabilities
        let invalidCapabilities: [String: Any] = [:]
        let files = Files(capabilities: invalidCapabilities)
        XCTAssertNil(files, "Files instance should not be created with invalid input")
    }

    func testPartiallyValidFilesInitialization() {
        // Partially valid files capabilities with some values missing
        let partialCapabilities: [String: Any] = [
            "files": [
                // Missing "blacklisted_files" and "directEditing" values
                "bigfilechunking": true,
                "comments": false,
                "undelete": true,
                "versioning": false,
                "version_labeling": true,
                "version_deletion": false
            ]
        ]

        let files = Files(capabilities: partialCapabilities)
        XCTAssertNotNil(files, "Files instance should be created even with partially valid input")
        XCTAssertEqual(files?.bigFileChunking, true, "Big File Chunking should be true")
        XCTAssertEqual(files?.blackListedFiles, [], "Blacklisted Files should default to an empty array")
        XCTAssertNil(files?.directEditing, "Direct Editing should be nil when not provided")
        XCTAssertEqual(files?.comments, false, "Comments should be false")
        XCTAssertEqual(files?.undelete, true, "Undelete should be true")
        XCTAssertEqual(files?.versioning, false, "Versioning should be false")
        XCTAssertEqual(files?.versionLabeling, true, "Version Labeling should be true")
        XCTAssertEqual(files?.versionDeletion, false, "Version Deletion should be false")
    }
}
