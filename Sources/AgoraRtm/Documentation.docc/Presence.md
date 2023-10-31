# Presence

Check the status of other users in channels.

## Overview

Presence provides the ability to monitor user online, offline, and user historical status change notifications. Through the Presence function, you can obtain the following information in real time:

- Real-time event notifications when users join or leave specified channels
- Customize temporary user status and its change real-time event notification
- Query which channels a specified user has joined or subscribed to
- Query which users join the specified channel and their temporary status data

> Presence applies to both message channels and stream channels.

## Fetch User Channel Activity

Using the ``RtmPresence/getUserChannels(for:)`` method, you can retrieve the channels that a specific user has joined in real-time.

```swift
let response = try? await getUserChannels(for: "12345")

print("user in \(response.channels.count) channels")

for channel in response.channels {
    switch channel {
    case .none(let name):
        print("Channel Name: \(name), Type: unknown")
    case .messageChannel(let name):
        print("Channel Name: \(name), Type: message")
    case .streamChannel(let name):
        print("Channel Name: \(name), Type: stream")
    }
}
```

- ``RtmPresence/getUserChannels(for:)``
- ``RtmPresence/getUserChannels(userId:completion:)``
- ``RtmUserChannelsResponse``

An example result would be to print:

```te   xt
user in 3 channels
Channel Name: Channel1, Type: message
Channel Name: Channel2, Type: message
Channel Name: Channel3, Type: stream
```

## Fetch Online Users in Channel

Using the ``RtmPresence/getOnlineUsers(in:options:)`` method, you can retrieve a list of users who are currently online in a specified channel.

```swift
let channelDetail: RtmChannelDetails = .message("channel-name") // This is just a sample channel detail.
let response = try? await getOnlineUsers(in: channelDetail)

print("\(response.totalOccupancy) users online in channel \(channelDetail)")

for (userId, states) in response.userStateList {
    print("User ID: \(userId)")
    for (key, value) in states {
        print("\t\(key): \(value)")
    }
}

if let nextPage = response.nextPage {
    print("Next page token: \(nextPage)")
}
```

- ``RtmPresence/getOnlineUsers(in:options:)``
- ``RtmPresence/getOnlineUsers(inChannel:options:completion:)``
- ``RtmOnlineUsersResponse``
- ``RtmOnlineUsersResponse/userStateList``

An example result might be:

```text
5 users online in channel ChannelName
User ID: User1
    stateKey1: stateValue1
    stateKey2: stateValue2
User ID: User2
    stateKey1: stateValue1
...
Next page token: xyz123
```

## Set Local User State in Channel

The ``RtmPresence/setUserState(inChannel:to:)`` method enables users to specify custom temporary states in a particular channel. This method is tailored for diverse scenarios such as displaying scores, in-game statuses, user's current mood, or any other temporary data.

The state remains active as long as the user stays online in the channel. However, note that this state is temporary and would be cleared when the user exits the channel or disconnects from the RTM service. Should you want the state to be persistent across sessions, consider caching it locally.

```swift
do {
    let customStates: [String: String] = ["gameStatus": "playing", "mood": "happy"]
    let response = try await presence.setUserState(
        inChannel: .messageChannel("channel-name"), to: customStates
    )
    print("setUserState succeeded!")
} catch let error {
    print("setUserState failed due to: \(error.localizedDescription)")
}
```

- ``RtmPresence/setUserState(inChannel:to:)``
- ``RtmPresence/setUserState(inChannel:to:completion:)``

Upon any changes to the user state, RTM will trigger an ``RtmPresenceEventType/remoteStateChanged`` event in ``RtmClientDelegate/rtmKit(_:didReceivePresenceEvent:)-2w28u``, which can be received by subscribing to the channel and setting the appropriate configurations.

## Remove Local User State in Channel

The ``RtmPresence/removeUserState(inChannel:keys:)`` method allows you to remove one or more temporary states for the local user within a specified channel. When a user successfully calls this method, other users subscribed to the same channel and with the Presence event ``RtmPresenceOptionFeatures/userState`` enabled will receive a notification of type ``RtmPresenceEventType/remoteStateChanged`` through the ``RtmClientDelegate/rtmKit(_:didReceivePresenceEvent:)-2w28u`` event.

```swift
do {
    let removedResponse = try await presence.removeUserState(
        inChannel: .messageChannel("channel-name"), keys: ["key1", "key2"]
    )
    print("User state(s) successfully removed!")
} catch let error {
    print("Failed to remove user state due to: \(error.localizedDescription)")
}
```

- ``RtmPresence/removeUserState(inChannel:keys:)``
- ``RtmPresence/removeUserState(fromChannel:keys:completion:)``

## Fetch User's State in a Channel

The ``RtmPresence/getState(ofUser:inChannel:)`` method provides a mechanism to retrieve the temporary state of a specified user within a particular channel.

```swift
do {
    let userStates = try await presence.getState(ofUser: "userId123", inChannel: .messageChannel("channel-name"))
    print("User states successfully fetched!")
    userStates.forEach { key, value in
        print("\t\(key): \(value)")
    }
} catch let error {
    print("Failed to fetch user state due to: \(error.localizedDescription)")
}
```

- ``RtmPresence/getState(ofUser:inChannel:)``
- ``RtmPresence/getState(ofUser:fromChannel:completion:)``

An example result might be:

```text
User states successfully fetched!
    stateKey1: stateValue1
    stateKey2: stateValue2
```
