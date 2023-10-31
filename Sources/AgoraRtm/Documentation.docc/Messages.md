# Messages

Sending and receiving messages.

## Overview

In the Agora Real-Time Messaging (RTM) SDK, messages play a crucial role in enabling communication between users. Whether you want to send a simple text message, a structured payload, or handle incoming messages, the RTM SDK provides the necessary tools to make communication seamless and efficient.

This article covers the basics of sending and receiving messages using the Agora RTM SDK. You'll learn how to send messages, handle incoming messages using delegates, and work with different message types.


## Sending Messages

### Prerequesites

Once your have followed the instructions in <doc:Initialising>, you should be ready to send your first messages.

You must be logged into RTM with ``RtmClientKit/login(byToken:)`` or ``RtmClientKit/login(byToken:completion:)``

### Text Messages

```swift
try? await rtmClient.publish(
    message: "Hello World",
    to: "channel-name"
)
```

### Codable Messages

```swift

struct Person: Codable {
    var name: String
    var age: Int
    var metadata: [String: String]
}

let maxPerson = Person(
    name: "max", age: 101,
    metadata: ["hobby": "climbing", "star_sign": "sagittarius"]
)

try? await rtmClient.publish(
    message: maxPerson,
    to: "channel-name"
)
```

----

Synchronous option for publishing is also available.

The async method will throw an error of type ``RtmErrorInfo`` if there's any issue creating the message or publishing it.

## Receiving Messages

### Prerequesites

- Logged in with ``RtmClientKit/login(byToken:)`` or ``RtmClientKit/login(byToken:completion:)``.
- Delegate assigned on ``RtmClientKit/init(config:delegate:)`` 

### Subscribe to the channel

Use ``RtmClientKit/subscribe(toChannel:features:)`` or ``RtmClientKit/subscribe(toChannel:features:completion:)`` to subscribe to the channel of choice:

```swift
try? await rtmClient.subscribe(
    toChannel: "channel-name",
    features: [.messages, .presence]
)
```

The async method will throw an error of type ``RtmErrorInfo`` if there's any issue subscribing to the channel.

### Delegate Message Events

All messages will arrive in ``RtmClientDelegate/rtmKit(_:didReceiveMessageEvent:)-fl9b``, and can be handled in the following ways

#### Text Messages

```swift
func rtmClient(_ rtmClient: RtmClientKit, didReceiveMessageEvent event: RtmMessageEvent) {
    let messageString = event.message.getString()
    switch event.message.content {
    case .string(let str): print(messageString)
    default: print("message is not a string")
    }
}
```

- ``RtmMessage/content``
- ``RtmMessageContent/string(_:)``


#### Codable Messages

```swift
func rtmClient(_ rtmClient: RtmClientKit, didReceiveMessageEvent event: RtmMessageEvent) {
    let personData = event.message.decodeMessage(as: Person.self)

    print(personData ?? "Message is not Person object")
}
```

- ``RtmMessage/decodeMessage(as:)``
