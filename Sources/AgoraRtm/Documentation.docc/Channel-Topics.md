# Channel Topics

Topic is a mechanism for data management, transmission and distribution in Stream Channels.

## Overview

Compared with Message Channel, the Topic mechanism in Stream Channel has excellent features such as higher message transmission rate, greater message concurrency and collaborative ability to synchronous transmission of audio and video data. Therefore, the Topic mechanism is widely used in metaverse, AR/VR, interactive games, real-time collaboration, parallel control and other scenarios.

- **Publisher Behavior**: 
  - Joining a topic registers the user as the message publisher, allowing them to send messages.
  - Leaving a topic unregisters the user, depriving them of the ability to send messages.
  
- **Subscriber Behavior**:
  - Subscribing to a topic lets the user receive its messages.
  - Unsubscribing stops the user from receiving messages.

> Publisher and subscriber behaviors are independent. Your actions as a publisher in a topic don't influence your actions as a subscriber in that same topic.

## Joining A Topic

To send messages within a Topic, you first need to join it. Currently, RTM allows a single client to join up to 8 topics within the same channel simultaneously.

When joining a Topic, you can use the options parameter to define specific attributes. These attributes will influence how messages are sent through the Topic, including message sequencing, priority, synchronization with audio/video data, and more. Detailed configurations can be found in the API documentation.

After successfully joining a Topic, the SDK triggers an ``RtmClientDelegate/rtmKit(_:didReceiveTopicEvent:)-2d0dr`` event. All users in the channel who are listening to Topic events will receive this notification.

```swift
do {
    _ = try await streamChannel.joinTopic("Basketball", with: nil)
} catch let err as RtmErrorInfo {
    print("\(err.operation) failed, errorCode \(err.errorCode), reason \(err.reason)")
}
```

- ``RtmStreamChannel/joinTopic(_:with:)``
- ``RtmStreamChannel/joinTopic(_:with:completion:)``
- ``RtmClientDelegate/rtmKit(_:didReceiveTopicEvent:)-2d0dr``

## Leaving a Topic

If you no longer want to send messages within a topic or exceed the limit for simultaneous topic joins, you can leave the topic.

```swift
do {
    _ = try await streamChannel.leaveTopic("Basketball")
} catch let err as RtmErrorInfo {
    print("leave topic failed, errorCode \(err.errorCode), reason \(err.reason)")
}
```

- ``RtmStreamChannel/leaveTopic(_:)``
- ``RtmStreamChannel/leaveTopic(_:completion:)``

## Subscribing to a Topic

You cna join a topic with no specified users, meaning it will subscribe to as many as it can, or you can specify users users with the following limitations:
- You can subscribe to 50 topics max per channel and pick up to 64 message senders per topic to maintain performance.
- List users you want messages from when subscribing. For instance, choosing `["UserA", "UserB"]` then `["UserB", "UserC"]` means you'll get messages from `["UserA", "UserB", "UserC"]`.
- If you don't list users, the system randomly selects up to 64 for you. If the topic has 64 or fewer users, you'll get all; if more, a random 64.

```swift
do {
    _ = try await streamChannel.subscribe(
        toTopic: "Basketball",
        withOptions: RtmTopicOption(users: ["user-1", "user-2"])
    )
} catch let err as RtmErrorInfo {
    print("subscription failed, errorCode \(err.errorCode), reason \(err.reason)")
}
```

- ``RtmStreamChannel/subscribe(toTopic:withOptions:)``
- ``RtmStreamChannel/subscribe(toTopic:withOptions:completion:)``
- ``RtmTopicOption/init(users:)``

## Unsubscribing from a Topic

If you're no longer interested in receiving messages from a topic or specific publishers within it, you can unsubscribe.

1. Specify the topic from which you'd like to unsubscribe.
2. Create an array of user IDs you want to stop receiving messages from, or pass `nil` to unsubscribe from all.
3. Use the ``RtmStreamChannel/unsubscribe(fromTopic:withOptions:)`` method.

```swift
do {
    _ = try await streamChannel.unsubscribe(
        fromTopic: "Basketball",
        withOptions: RtmTopicOption(users: ["user-1", "user-2"])
    )
} catch let err as RtmErrorInfo {
    print("unsubscribe failed, errorCode \(err.errorCode), reason \(err.reason)")
}
```

- ``RtmStreamChannel/unsubscribe(fromTopic:withOptions:)``
- ``RtmStreamChannel/unsubscribe(fromTopic:withOptions:completion:)``

To unsubscribe from all users, you can use ``RtmStreamChannel/getSubscribedUserList(forTopic:)`` to get the full list of subscribed users.
