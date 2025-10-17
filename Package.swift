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
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NextcloudCapabilitiesKit",
            targets: ["NextcloudCapabilitiesKit"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.55.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NextcloudCapabilitiesKit",
            swiftSettings: [
              .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "NextcloudCapabilitiesKitTests",
            dependencies: ["NextcloudCapabilitiesKit"],
            swiftSettings: [
              .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
    ],
)
