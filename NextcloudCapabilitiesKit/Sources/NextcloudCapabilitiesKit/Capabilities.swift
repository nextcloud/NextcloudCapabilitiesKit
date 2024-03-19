//
//  Capabilities.swift
//
//
//  Created by Claudio Cambra on 19/3/24.
//

import Foundation

public struct Capabilities {
    public let filesSharing: FilesSharing
    public let notifyPush: NotifyPush

    public init() {
        filesSharing = FilesSharing()
        notifyPush = NotifyPush()
        debugPrint("Providing defaulted capabilities!")
    }

    public init(data: Data) {
        guard let anyJson = try? JSONSerialization.jsonObject(with: data, options: []) else {
            let jsonString = String(data: data, encoding: .utf8) ?? "UNKNOWN"
            debugPrint("Received capabilities is not valid JSON! \(jsonString)")
            filesSharing = FilesSharing()
            notifyPush = NotifyPush()
            return
        }

        guard let jsonDict = anyJson as? [String : Any],
              let ocsData = jsonDict["ocs"] as? [String : Any],
              let receivedData = ocsData["data"] as? [String : Any],
              let capabilities = receivedData["capabilities"] as? [String : Any]
        else {
            let jsonString = anyJson as? [String : Any] ?? ["UNKNOWN" : "UNKNOWN"]
            debugPrint("Could not parse share capabilities! \(jsonString)")
            filesSharing = FilesSharing()
            notifyPush = NotifyPush()
            return
        }

        filesSharing = FilesSharing(capabilities: capabilities)
        notifyPush = NotifyPush(capabilities: capabilities)
    }
}
