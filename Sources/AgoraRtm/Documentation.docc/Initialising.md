# Initialising

Set up ``RtmClientConfig`` and ``RtmClientKit`` for Signaling

## Overview

This topic provides information on how to initialize the ``RtmClientConfig`` instance in your Agora Real-time Messaging SDK package.

## Creating an RtmClientConfig instance

To get started with the Agora Real-time Messaging SDK, you need to create an `RtmClientConfig` instance and configure it according to your application's requirements.

You can initialize the `RtmClientConfig` using its default initializer:

```swift
import AgoraRtm

// Create an `RtmClientConfig` instance
let rtmConfig = RtmClientConfig(
    appId: "example-appId",
    userId: "example-username"
)
```

## Setting Properties

Once you've initialized the RtmClientConfig instance, you can set various properties to customize its behavior. Here's an example of setting the ``RtmClientConfig/areaCode`` property using ``RtmAreaCode`` to choose where your data can be routed thorugh:

```swift
// Set the areaCode property
rtmConfig.areaCode = [.northAmerica, .europe]
```

## Creating an RtmClientKit instance

After configuring the ``RtmClientConfig``, you can proceed to create an ``RtmClientKit`` instance using ``RtmClientKit/init(config:delegate:)``. The RtmClientKit is the core class that you'll use to interact with the Agora Real-time Messaging services.

Here's how you can create an RtmClientKit instance:

```swift
let rtmClient = RtmClientKit(config: rtmConfig, delegate: self)
```

Change `self` for whatever you're using as the ``RtmClientDelegate``.

## See More

