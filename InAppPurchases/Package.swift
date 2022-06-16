// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "InAppPurchases",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "InAppPurchases",
            targets: ["InAppPurchases"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/RevenueCat/purchases-ios", from: "4.0.0"),
        .package(path: "../Lang"),
        .package(path: "../Physics"),
        .package(path: "../Squanch"),
        .package(path: "../Tracking")
    ],
    targets: [
        .target(
            name: "InAppPurchases",
            dependencies: [
                .product(name: "RevenueCat", package: "purchases-ios"),
                .product(name: "Lang", package: "Lang"),
                .product(name: "Physics", package: "Physics"),
                .product(name: "Squanch", package: "Squanch"),
                .product(name: "Tracking", package: "Tracking")
            ]
        )
    ]
)