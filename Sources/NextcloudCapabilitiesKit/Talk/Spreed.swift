//
//  Spreed.swift
//
//
//  Created by Claudio Cambra on 7/4/24.
//

import Foundation

public struct Spreed: Equatable {
    let config: SpreedConfig?
    let features: [String]
    let version: String

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["spreed"] as? [String : Any] else {
            debugPrint("No spreed data in received capabilities.")
            return nil
        }

        config = SpreedConfig(spreedCapabilities: capabilities)
        features = capabilities["features"] as? [String] ?? []
        version = capabilities["version"] as? String ?? ""
    }
}
