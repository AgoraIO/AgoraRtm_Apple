// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "AgoraRTM",
    platforms: [.iOS(.v12), .macOS(.v10_15)],
    products: [
        .library(
            name: "AgoraRTM",
            targets: ["AgoraRtmKit"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "AgoraRtmKit",
            url: "https://download.agora.io/rtmsdk/release/AgoraRtmKit.xcframework_2.2.4_lite_iOS.zip",
            checksum: "714e19b248930ae46ef09d54fe8d6486956f1ee74df312fa10f5180dad975a5e"
        )
    ]
)
