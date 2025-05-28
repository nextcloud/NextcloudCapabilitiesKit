//
//  Activity.swift
//
//
//  Created by Claudio Cambra on 6/4/24.
//

import Foundation

public struct Activity: Equatable {
    public let apiV2: [String]

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["activity"] as? [String : Any] else {
            debugPrint("No activity data in received capabilities.")
            return nil
        }

        apiV2 = capabilities["apiv2"] as? [String] ?? []
    }
}
