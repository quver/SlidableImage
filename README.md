# SlidableImage

[![CI](https://github.com/quver/SlidableImage/actions/workflows/ci.yml/badge.svg)](https://github.com/quver/SlidableImage/actions/workflows/ci.yml)
[![GitHub license](https://img.shields.io/github/license/quver/SlidableImage.svg)](https://github.com/quver/SlidableImage/blob/main/LICENSE)
[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fquver%2FSlidableImage%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/quver/SlidableImage)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fquver%2FSlidableImage%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/quver/SlidableImage)

SwiftUI before & after image slider with a draggable divider.

## Requirements

- iOS 15+ / macOS 12+
- Swift 6.1+
- Xcode 16.4+

## Installation

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/quver/SlidableImage.git", from: "5.0.0")
]
```

Or add it directly in Xcode via **File → Add Package Dependencies**.

## Usage

```swift
SlidableImage(
    arrows: { Arrows() },
    leftView: { Image("before") },
    rightView: { Image("after") }
)
```

### Custom arrows

```swift
SlidableImage(
    arrows: {
        Arrows(arrowColor: .black, backgroundColor: .white)
    },
    leftView: { Image("before") },
    rightView: { Image("after") }
)
```

### Custom divider

Pass any SwiftUI view as the `arrows` parameter:

```swift
SlidableImage(
    arrows: {
        Image(systemName: "arrow.left.and.right")
            .padding()
            .background(.ultraThinMaterial, in: Circle())
    },
    leftView: { Image("before") },
    rightView: { Image("after") }
)
```

## Documentation

Full API documentation is available at [quver.github.io/SlidableImage](https://quver.github.io/SlidableImage/documentation/slidableimage/).
