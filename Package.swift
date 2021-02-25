// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "SwipePopViewController",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "SwipePopViewController",
            targets: ["SwipePopViewController"]),
    ],
    targets: [
        .target(
            name: "SwipePopViewController",
            dependencies: []),
        .testTarget(
            name: "SwipePopViewControllerTests",
            dependencies: ["SwipePopViewController"]),
    ]
)
