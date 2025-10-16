//
//  Dav.swift
//
//
//  Created by Claudio Cambra on 7/4/24.
//

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
