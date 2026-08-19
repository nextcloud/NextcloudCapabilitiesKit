//  SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
//  SPDX-License-Identifier: LGPL-3.0-or-later

import Foundation

public struct Theming: Equatable, Sendable {
    public let name: String
    public let productName: String
    public let url: URL?
    public let imprintURL: URL?
    public let privacyURL: URL?
    public let slogan: String
    public let color: String
    public let colorText: String
    public let colorElement: String
    public let colorElementBright: String
    public let colorElementDark: String
    public let logoURL: URL?
    public let background: String
    public let backgroundText: String
    public let backgroundPlain: Bool
    public let backgroundDefault: Bool
    public let logoHeaderURL: URL?
    public let faviconURL: URL?
    public let primaryColor: String
    public let backgroundColor: String
    public let defaultPrimaryColor: String
    public let defaultBackgroundColor: String
    public let inverted: Bool
    public let cacheBuster: String
    public let enabledThemes: [String]

    @available(*, deprecated, renamed: "logoURL")
    public var logoUrl: URL? {
        logoURL
    }

    @available(*, deprecated, renamed: "logoHeaderURL")
    public var logoHeaderUrl: URL? {
        logoHeaderURL
    }

    @available(*, deprecated, renamed: "faviconURL")
    public var faviconUrl: URL? {
        faviconURL
    }

    init?(capabilities: [String: Any]) {
        guard let capabilities = capabilities["theming"] as? [String: Any] else {
            debugPrint("No theming data in received capabilities")
            return nil
        }

        name = capabilities["name"] as? String ?? ""
        productName = capabilities["productName"] as? String ?? ""
        url = URL(string: capabilities["url"] as? String ?? "")
        imprintURL = URL(string: capabilities["imprintUrl"] as? String ?? "")
        privacyURL = URL(string: capabilities["privacyUrl"] as? String ?? "")
        slogan = capabilities["slogan"] as? String ?? ""
        color = capabilities["color"] as? String ?? ""
        colorText = capabilities["color-text"] as? String ?? ""
        colorElement = capabilities["color-element"] as? String ?? ""
        colorElementBright = capabilities["color-element-bright"] as? String ?? ""
        colorElementDark = capabilities["color-element-dark"] as? String ?? ""
        logoURL = URL(string: capabilities["logo"] as? String ?? "")
        background = capabilities["background"] as? String ?? ""
        backgroundText = capabilities["background-text"] as? String ?? ""
        backgroundPlain = capabilities["background-plain"] as? Bool ?? false
        backgroundDefault = capabilities["background-default"] as? Bool ?? false
        logoHeaderURL = URL(string: capabilities["logoheader"] as? String ?? "")
        faviconURL = URL(string: capabilities["favicon"] as? String ?? "")
        primaryColor = capabilities["primaryColor"] as? String ?? ""
        backgroundColor = capabilities["backgroundColor"] as? String ?? background
        defaultPrimaryColor = capabilities["defaultPrimaryColor"] as? String ?? ""
        defaultBackgroundColor = capabilities["defaultBackgroundColor"] as? String ?? ""
        inverted = capabilities["inverted"] as? Bool ?? false
        cacheBuster = capabilities["cacheBuster"] as? String ?? ""
        enabledThemes = capabilities["enabledThemes"] as? [String] ?? []
    }
}
