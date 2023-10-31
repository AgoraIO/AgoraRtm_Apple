# ``AgoraRtm/RtmStreamChannel``

## Overview

Stream Channels are a type of channel in RTM based on the Room model. Unlike Message Channels, before using Stream Channel methods, you must first create an ``RtmStreamChannel`` instance. Once you've joined a Stream Channel, you can listen for event notifications within that channel. However, if you want to send or receive messages, you'll need to utilize the Topic feature (<doc:Channel-Topics>). RTM allows you to have thousands of Stream Channels in your app. However, due to client-side performance and bandwidth constraints, there's a limit to the number of channels a single client can join. For details on this limit, please refer to the API usage constraints.

To process received messages and event notifications, apart from joining the channel, you also need to set up event monitoring. See <doc:Events>.

## Creating a Channel

Before using a Stream Channel, you need to call the createStreamChannel method to instantiate it. After successfully doing so, you can leverage various Stream Channel methods, such as joining or leaving channels, and more.

```swift
let streamChannel = rtmClient.createStreamChannel("channel-name")
```

## Joining a Channel

After creating an ``RtmStreamChannel`` instance, use the ``RtmStreamChannel/join(with:)`` method to join the Stream Channel.

```swift
do {
    let joinOptions = RtmJoinChannelOption(token: "agora-token", features = .presence)
    _ = try await streamChannel.join(with: joinOptions)
} catch let err as RtmErrorInfo {
    print("join failed, errorCode \(err.errorCode), reason \(err.reason)")
}
```

- ``RtmStreamChannel/join(with:)``
- ``RtmStreamChannel/join(with:completion:)``

## Leaving a Channel

If you no longer need to receive notifications from a particular channel, you can use the ``RtmStreamChannel/leave()`` method.

```swift
try? streamChannel.leave()
```

- ``RtmStreamChannel/leave()``
- ``RtmStreamChannel/leave(completion:)``

## Topics

### Joining a Channel

- ``RtmStreamChannel/join(with:)``
- ``RtmStreamChannel/join(with:completion:)``

### Leaving a Channel

- ``RtmStreamChannel/leave()``
- ``RtmStreamChannel/leave(completion:)``
