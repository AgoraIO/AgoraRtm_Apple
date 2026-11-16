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
            url: "https://download.agora.io/rtm2/release/AgoraRtmKit.xcframework_2.3.1.zip",
            checksum: "8b40e9352776f07a8184f1a23b85c2a160f74d85a7c5230b992f6e0ad3826fe1"
        ),
        .binaryTarget(
            name: "aosl",
            url: "https://download.agora.io/rtm2/release/aosl.xcframework_1.3.5.zip",
            checksum: "74c15ef78794e3e97fbde705780e97a75f6ed184533f3d79fdf8091c1b62186b"
        )
    ]
)
