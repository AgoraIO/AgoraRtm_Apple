> [!WARNING]
> This is a beta product


# AgoraRtm

<p align="center">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FAgoraIO%2FAgoraRtm_Apple%2Fbadge%3Ftype%3Dswift-versions" />
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FAgoraIO%2FAgoraRtm_Apple%2Fbadge%3Ftype%3Dplatforms" />
</p>

AgoraRtm is a Swift package that provides an easy-to-use interface for integrating Agora Real-Time Messaging (RTM) into your iOS applications. It offers a set of classes and methods that enable you to establish real-time messaging and communication channels.

## Features

- **User Authentication:** Authenticate users using tokens for secure communication.
- **Message Communication:** Send and receive real-time messages between users.
- **Presence Management:** Query and update the presence status of users.
- **Lock Management:** Manage locks for synchronization between users.
- **Storage Management:** Store and retrieve user-specific data in real time.
- **Topic Management:** Create and manage channels for different topics.

## Requirements

- iOS 13.0+ or macOS 10.15
- Xcode 14.0+
- Swift 5.8+

## Installation

To integrate AgoraRtm into your Xcode project, you can use Swift Package Manager. Here's how:

1. In Xcode, open your project.
2. Select File > Swift Packages > Add Package Dependency.
3. Enter the package repository URL: `https://github.com/AgoraIO/AgoraRtm_Apple.git`.
4. Choose a version rule or enter a specific branch, tag, or commit hash.
5. Click Next, then Add `AgoraRtmKit-Swift` library.

## Getting Started

### Initialization

To get started with AgoraRtm, you need to initialize an `RtmClientConfig` instance and create an `RtmClientKit` instance with it. Here's an example:

```swift
import AgoraRtm

// Create an `RtmClientConfig` instance
let rtmConfig = RtmClientConfig(
    appId: "example-appId",
    userId: "example-username"
)

let rtmClient = RtmClientKit(config: rtmConfig, delegate: self)
```
