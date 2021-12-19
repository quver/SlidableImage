// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SlidableImage",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "SlidableImage",
            targets: ["SlidableImage"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SlidableImage",
            dependencies: [])
    ]
)
