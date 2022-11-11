// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "BlinkKit",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_15),
        .tvOS(.v9),
        .watchOS(.v3),
    ],
    products: [
        .library(name: "BlinkKit", targets: ["BlinkKit"])
    ],
    dependencies: [
        .package(name: "BlinkOpenAPI", url: "https://github.com/grigorye/BlinkOpenAPI-Swift", .branch("main")),
        .package(url: "https://github.com/grigorye/GETracing", .branch("master")),
    ],
    targets: [
        .target(
            name: "BlinkKit",
            dependencies: [
                "BlinkOpenAPI",
                "GETracing",
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
