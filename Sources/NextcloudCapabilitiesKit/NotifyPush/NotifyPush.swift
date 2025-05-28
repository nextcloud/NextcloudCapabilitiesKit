//
//  NotifyPush.swift
//
//
//  Created by Claudio Cambra on 20/3/24.
//

import Foundation

public enum PushNotificationType: String {
    case files = "files"
    case activities = "activities"
    case notifications = "notifications"
}

public struct NotifyPush: Equatable {
    public let available: Bool
    public let types: Set<PushNotificationType>
    public let endpoints: Endpoints?

    init() {
        available = true
        types = []
        endpoints = nil
    }

    init?(capabilities: [String: Any]) {
        guard let notifyPushCapabilities = capabilities["notify_push"] as? [String : Any] else {
            debugPrint("No notifyPush data in received capabilities.")
            return nil
        }

        available = true
        
        let receivedTypes = notifyPushCapabilities["type"] as? [String] ?? []
        var gatheredTypes: Set<PushNotificationType> = []
        for receivedType in receivedTypes {
            if receivedType == PushNotificationType.files.rawValue {
                gatheredTypes.insert(.files)
            } else if receivedType == PushNotificationType.activities.rawValue {
                gatheredTypes.insert(.activities)
            } else if receivedType == PushNotificationType.notifications.rawValue {
                gatheredTypes.insert(.notifications)
            }
        }
        types = gatheredTypes
        endpoints = Endpoints(notifyPushCapabilities: notifyPushCapabilities)
    }
}
