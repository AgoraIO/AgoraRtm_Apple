# Events

Catching common events such as messages.

## Overview

This topic provides information on handling Real-Time Messaging (RTM) events in the Agora Real-time Messaging SDK package.

## Event Handling with Delegate

To receive and handle various RTM events, you can implement the `RtmClientDelegate` protocol. This protocol defines a set of methods that you can use to capture events such as message receptions, presence updates, lock events, storage events, topic events, token privilege expiration, and changes in the connection state.

### Implementing the `RtmClientDelegate` Protocol

To get started, adopt the ``RtmClientDelegate`` protocol in a class or structure. Then, implement the methods defined by the protocol according to your application's requirements.

### Message Events

One of the most common events in the RTM system is the message event. This event is triggered when a new message is received by the client. You can use the `didReceiveMessageEvent` method of the `RtmClientDelegate` protocol to handle message events.

Here's an example of how to use the `didReceiveMessageEvent` method, which returns an ``RtmMessageEvent`` object:

```swift
extension MyRtmDelegate: RtmClientDelegate {
    func rtmClient(_ rtmClient: RtmClientKit, didReceiveMessageEvent event: RtmMessageEvent) {
        // Extract the received message
        let receivedMessage = event.message
        
        // Extract the publisher's user ID
        let publisherId = event.publisher
        
        // Handle the received message and sender
        print("Received message: \(receivedMessage) from user: \(publisherId)")
    }
}
```
