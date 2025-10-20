// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// SPDX-FileCopyrightText: 2024 Nextcloud GmbH and Nextcloud contributors
// SPDX-License-Identifier: LGPL-3.0-or-later
//
import PackageDescription

let package = Package(
    name: "NextcloudCapabilitiesKit",
    products: [
        .library(name: "NextcloudCapabilitiesKit", targets: ["NextcloudCapabilitiesKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.55.0")
    ],
    targets: [
        .target(name: "NextcloudCapabilitiesKit"),
        .testTarget(name: "NextcloudCapabilitiesKitTests", dependencies: ["NextcloudCapabilitiesKit"])
    ]
)
