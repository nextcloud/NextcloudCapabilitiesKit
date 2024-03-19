//
//  Endpoints.swift
//
//
//  Created by Claudio Cambra on 20/3/24.
//

import Foundation

public struct Endpoints {
    public let websocket: String?

    init?(notifyPushCapabilities: [String: Any]) {
        guard let endpointCaps = notifyPushCapabilities["endpoints"] as? [String : Any] else {
            debugPrint("No endpoints data in received capabilities.")
            return nil
        }

        websocket = notifyPushCapabilities["websocket"] as? String
    }
}
