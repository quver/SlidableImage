// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "SlidableImage",
    platforms: [
        .iOS(.v15)
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
