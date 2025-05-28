//
//  Capabilities.swift
//
//
//  Created by Claudio Cambra on 19/3/24.
//

import Foundation

public struct Capabilities: Equatable {
    public let core: Core?
    public let bruteForce: BruteForce?
    public let files: Files?
    public let activity: Activity?
    public let notifications: Notifications?
    public let dav: Dav?
    public let passwordPolicy: PasswordPolicy?
    public let spreed: Spreed?
    public let theming: Theming?
    public let userStatus: UserStatus?
    public let filesSharing: FilesSharing?
    public let notifyPush: NotifyPush?

    public init?(data: Data) {
        guard let anyJson = try? JSONSerialization.jsonObject(with: data, options: []) else {
            let jsonString = String(data: data, encoding: .utf8) ?? "UNKNOWN"
            debugPrint("Received capabilities is not valid JSON! \(jsonString)")
            return nil
        }

        guard let jsonDict = anyJson as? [String : Any],
              let ocsData = jsonDict["ocs"] as? [String : Any],
              let receivedData = ocsData["data"] as? [String : Any],
              let capabilities = receivedData["capabilities"] as? [String : Any]
        else {
            let jsonString = anyJson as? [String : Any] ?? ["UNKNOWN" : "UNKNOWN"]
            debugPrint("Could not parse capabilities! \(jsonString)")
            return nil
        }

        core = Core(capabilities: capabilities)
        bruteForce = BruteForce(capabilities: capabilities)
        files = Files(capabilities: capabilities)
        activity = Activity(capabilities: capabilities)
        notifications = Notifications(capabilities: capabilities)
        dav = Dav(capabilities: capabilities)
        passwordPolicy = PasswordPolicy(capabilities: capabilities)
        spreed = Spreed(capabilities: capabilities)
        theming = Theming(capabilities: capabilities)
        userStatus = UserStatus(capabilities: capabilities)
        filesSharing = FilesSharing(capabilities: capabilities)
        notifyPush = NotifyPush(capabilities: capabilities)
    }
}
