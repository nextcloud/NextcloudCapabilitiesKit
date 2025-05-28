//
//  Theming.swift
//
//
//  Created by Claudio Cambra on 6/4/24.
//

import Foundation

public struct Theming: Equatable {
    let name: String
    let url: URL?
    let slogan: String
    let color: String
    let colorText: String
    let colorElement: String
    let colorElementBright: String
    let colorElementDark: String
    let logoUrl: URL?
    let backgroundColor: String
    let backgroundPlain: Bool
    let backgroundDefault: Bool
    let logoHeaderUrl: URL?
    let faviconUrl: URL?

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["theming"] as? [String: Any] else {
            debugPrint("No theming data in received capabilities")
            return nil
        }

        name = capabilities["name"] as? String ?? ""
        url = URL(string: capabilities["url"] as? String ?? "")
        slogan = capabilities["slogan"] as? String ?? ""
        color = capabilities["color"] as? String ?? ""
        colorText = capabilities["color-text"] as? String ?? ""
        colorElement = capabilities["color-element"] as? String ?? ""
        colorElementBright = capabilities["color-element-bright"] as? String ?? ""
        colorElementDark = capabilities["color-element-dark"] as? String ?? ""
        logoUrl = URL(string: capabilities["logo"] as? String ?? "")
        backgroundColor = capabilities["background"] as? String ?? ""
        backgroundPlain = capabilities["background-plain"] as? Bool ?? false
        backgroundDefault = capabilities["background-default"] as? Bool ?? false
        logoHeaderUrl = URL(string: capabilities["logoheader"] as? String ?? "")
        faviconUrl = URL(string: capabilities["favicon"] as? String ?? "")
    }
}
