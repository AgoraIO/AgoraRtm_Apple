// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "AgoraRTM",
    platforms: [.iOS(.v12), .macOS(.v10_15)],
    products: [
        .library(
            name: "AgoraRTM",
            targets: ["AgoraRtmKit", "aosl"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "AgoraRtmKit",
            url: "https://download.agora.io/rtmsdk/release/AgoraRtmKit.xcframework.zip",
            checksum: "40a9656b8e5978b4f421d0934f082399b97c9bca876cacb7eea7b03cbe9c9c94"
        ),
        .binaryTarget(
            name: "aosl",
            url: "https://download.agora.io/rtmsdk/release/aosl.xcframework.zip",
            checksum: "4d1768316f2738e339627cddb3186bb74b5163241e4e47ffd05e83a41a89027d"
        )
    ]
)
