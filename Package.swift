// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "BlinkKit",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_15),
        .tvOS(.v11),
        .watchOS(.v4),
    ],
    products: [
        .library(name: "BlinkKit", targets: ["BlinkKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/grigorye/BlinkOpenAPI-Swift", branch: "main")
    ],
    targets: [
        .target(
            name: "BlinkKit",
            dependencies: [
                .product(name: "BlinkOpenAPI", package: "BlinkOpenAPI-Swift")
            ]
        ),
        .testTarget(
            name: "BlinkKitTests",
            dependencies: [
                "BlinkKit"
            ]
        ),
    ]
)
