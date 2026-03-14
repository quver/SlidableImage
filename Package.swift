// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "SlidableImage",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "SlidableImage",
            targets: ["SlidableImage"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
    ],
    targets: [
        .target(name: "SlidableImage"),
    ]
)
