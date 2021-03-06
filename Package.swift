// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftPlantUML",
    products: [
        .library(
            name: "SwiftPlantUMLFramework",
            targets: ["SwiftPlantUMLFramework"]
        ),
        .executable(name: "swiftplantuml", targets: ["swiftplantuml"]),
    ],
    dependencies: [
        .package(name: "SourceKitten", url: "https://github.com/jpsim/SourceKitten", from: "0.31.0"),
        .package(name: "swift-argument-parser", url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.3.1")),
        .package(name: "SwiftyBeaver", url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .exact("1.9.3")),
    ],
    targets: [
        .target(
            name: "swiftplantuml",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "SwiftPlantUMLFramework",
                .product(name: "SwiftyBeaver", package: "SwiftyBeaver"),
            ]
        ),
        .target(
            name: "SwiftPlantUMLFramework",
            dependencies: [
                .product(name: "SourceKittenFramework", package: "SourceKitten"),
            ]
        ),
        .testTarget(
            name: "SwiftPlantUMLFrameworkTests",
            dependencies: [
                "SwiftPlantUMLFramework",
            ],
            resources: [
                .copy("TestData"),
            ]
        ),
    ]
)
