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
            url: "https://download.agora.io/rtm2/release/AgoraRtmKit.xcframework_2.2.8.zip",
            checksum: "6b2381dcbdc4bbbbf2e36fc715a09fae7906fd975ac6c78346ac7b67f3563e24"
        ),
        .binaryTarget(
            name: "aosl",
            url: "https://download.agora.io/rtm2/release/aosl.xcframework_1.3.0.zip",
            checksum: "40748c5fdce72318a68664ff2d93473cd3a1511b49143056977b1ef36d12450f"
        )
    ]
)
