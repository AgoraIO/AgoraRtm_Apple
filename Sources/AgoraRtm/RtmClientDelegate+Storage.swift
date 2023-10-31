//
//  RtmClientDelegate+Storage.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// Storage type indicating whether the storage event was triggered by user or channel.
public enum RtmStorageType: Int {
    /// The storage event is not associated with any specific storage type.
    case none = 0
    /// The storage event is associated with user storage.
    case user = 1
    /// The storage event is associated with channel storage.
    case channel = 2
}

/// Storage event type, indicating the storage operation.
public enum RtmStorageEventType: Int {
    /// Unknown event type.
    case none = 0
    /// Triggered when a user subscribes to user metadata state or joins a channel with `options.withMetadata = true`.
    case snapshot = 1
    /// Triggered when a remote user sets metadata.
    case set = 2
    /// Triggered when a remote user updates metadata.
    case update = 3
    /// Triggered when a remote user removes metadata.
    case remove = 4
}

/// Represents a storage event in the Agora RTM system.
public struct RtmStorageEvent {
    /// The channel type of the storage event, `message` or `stream`.
    public let channelType: RtmChannelType
    /// The storage type of the event, `user` or `channel`.
    public let storageType: RtmStorageType
    /// The type of the storage event.
    public let eventType: RtmStorageEventType
    /// The target name of the user or channel, depending on the storage type.
    public let target: String
    /// The metadata information associated with the storage event.
    public let data: AgoraRtmMetadata

    /// Initializes an instance of `RtmStorageEvent`.
    /// - Parameter objcStorageEvent: The AgoraRtmStorageEvent object to extract storage event details from.
    internal init(_ objcStorageEvent: AgoraRtmStorageEvent) {
        channelType = .init(rawValue: objcStorageEvent.channelType.rawValue) ?? .none
        storageType = .init(rawValue: objcStorageEvent.storageType.rawValue) ?? .none
        eventType = .init(rawValue: objcStorageEvent.eventType.rawValue) ?? .none
        target = objcStorageEvent.target
        data = objcStorageEvent.data
    }
}
