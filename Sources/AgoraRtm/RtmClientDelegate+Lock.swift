//
//  RtmClientDelegate+Lock.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// The types of lock events that can be received from the AgoraRtmKit.
public enum RtmLockEventType: Int {
    /// Unknown lock event type.
    case none = 0
    /// The lock snapshot event type.
    case snapshot = 1
    /// The lock set event type.
    case lockSet = 2
    /// The lock removed event type.
    case lockRemoved = 3
    /// The lock acquired event type.
    case lockAcquired = 4
    /// The lock released event type.
    case lockReleased = 5
    /// The lock expired event type.
    case lockExpired = 6
}

/// A representation of a lock detail from the AgoraRtmKit.
public class RtmLockDetail {
    /// The name of the lock.
    public var lockName: String
    /// The owner of the lock. Only valid when the user gets locks or receives
    /// LockEvent with ``RtmLockEventType/snapshot``.
    public var owner: String
    /// The time-to-live (TTL) of the lock.
    public var ttl: Int32

    /// Initializes an instance of ``RtmLockDetail`` with the provided lock details from ``AgoraRtmLockDetail``.
    ///
    /// - Parameter agorartmLockDetail: The AgoraRtmLockDetail instance to extract lock details from.
    internal init(_ agorartmLockDetail: AgoraRtmLockDetail) {
        self.lockName = agorartmLockDetail.lockName
        self.owner = agorartmLockDetail.owner
        self.ttl = agorartmLockDetail.ttl
    }
}

/// A representation of a lock event from the AgoraRtmKit.
public struct RtmLockEvent {
    /// The type of channel for the lock event.
    public let channelType: RtmChannelType
    /// The type of lock event.
    public let eventType: RtmLockEventType
    /// The name of the channel where the lock event was triggered.
    public let channelName: String
    /// The list of lock details for the event.
    public let lockDetailList: [RtmLockDetail]

    /// Initializes an instance of `RtmLockEvent` with the provided lock event details from AgoraRtmLockEvent.
    ///
    /// - Parameter objcLockEvent: The AgoraRtmLockEvent instance to extract lock event details from.
    internal init(_ objcLockEvent: AgoraRtmLockEvent) {
        channelType = .init(rawValue: objcLockEvent.channelType.rawValue) ?? .none
        eventType = .init(rawValue: objcLockEvent.eventType.rawValue) ?? .none
        channelName = objcLockEvent.channelName
        lockDetailList = objcLockEvent.lockDetailList.map { .init($0) }
    }
}
