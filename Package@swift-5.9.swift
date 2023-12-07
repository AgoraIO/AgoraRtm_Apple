// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AgoraRtm",
    platforms: [.iOS(.v12), .macOS(.v10_15), .visionOS(.v1)],
    products: [
        .library(
            name: "AgoraRtmKit-Swift",
            targets: ["AgoraRtm"]),
        .library(
            name: "AgoraRtmKit-OC",
            targets: ["AgoraRtmKit-OC"]
        )
    ],
    dependencies: [
//        .package(url: "https://github.com/realm/SwiftLint.git", from: .init(0, 52, 4))
    ],
    targets: [
        .target(
            name: "AgoraRtm",
            dependencies: ["AgoraRtmKit-OC"]
//            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
//        .binaryTarget(name: "AgoraRtmKit-OC", path: "AgoraRtmKit.xcframework.zip"),
        .binaryTarget(
            name: "AgoraRtmKit-OC",
            url: "https://github.com/AgoraIO/AgoraRtm_Apple/releases/download/2.1.8-beta.1/AgoraRtmKit.xcframework.zip",
            checksum: "b180e27e9cad4f2bb4787e2cb383f1cc7d2e6455da2f04ca930cb8f0746b0e09"
        ),
        .testTarget(
            name: "AgoraRtmTests",
            dependencies: ["AgoraRtm"]
//            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        )
    ]
)
