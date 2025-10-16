//
//  ChunkedUpload.swift
//
//
//  Created by Claudio Cambra on 16/1/25.
//

import Foundation

public struct ChunkedUpload: Equatable {
    public let maxParallelCount: Int64
    public let maxChunkSize: Int64

    init?(filesCapabilities: [String: Any]) {
        guard let capabilities = filesCapabilities["chunked_upload"] as? [String: Any] else {
            debugPrint("No chunked upload data in received capabilities.")
            return nil
        }

        maxParallelCount = Int64(capabilities["max_parallel_count"] as? Int ?? -1)
        maxChunkSize = Int64(capabilities["max_size"] as? Int ?? -1)
    }
}
