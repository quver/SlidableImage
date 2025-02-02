// swift-tools-version:6.0

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
    targets: [
        .target(name: "SlidableImage"),

    ]
)
