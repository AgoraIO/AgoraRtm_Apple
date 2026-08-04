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
            url: "https://download.agora.io/rtm2/release/AgoraRtmKit.xcframework_2.3.0.zip",
            checksum: "a789d38bf63c97ab9db6c6574fd17de3e820dae44b449ca680624a57fcebb3b3"
        ),
        .binaryTarget(
            name: "aosl",
            url: "https://download.agora.io/rtm2/release/aosl.xcframework_1.3.5.zip",
            checksum: "74c15ef78794e3e97fbde705780e97a75f6ed184533f3d79fdf8091c1b62186b"
        )
    ]
)
