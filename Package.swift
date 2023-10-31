// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AgoraRtm",
    platforms: [.iOS(.v11), .macOS(.v10_15)],
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
            url: "https://github.com/AgoraIO/AgoraRtm_Apple/releases/download/2.1.7-beta.1/AgoraRtmKit.xcframework.zip",
            checksum: "4e6c6dc8e02ed3b3acf52806f38c9cb41a51a99c1182036507352e591b896922"
        ),
        .testTarget(
            name: "AgoraRtmTests",
            dependencies: ["AgoraRtm"]
//            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        )
    ]
)
