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
            url: "https://download.agora.io/rtmsdk/release/AgoraRtmKit.xcframework_2.2.4.zip",
            checksum: "48993735528efaadc4009478288c32993818a4a23620e2b17f4608c3f78bc9e5"
        ),
        .binaryTarget(
            name: "aosl",
            url: "https://download.agora.io/rtmsdk/release/aosl.xcframework.zip",
            checksum: "4d1768316f2738e339627cddb3186bb74b5163241e4e47ffd05e83a41a89027d"
        )
    ]
)
