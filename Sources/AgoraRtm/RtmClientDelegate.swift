//
//  RtmClientDelegate.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// A delegate protocol for receiving Real-Time Messaging (RTM) events and notifications from the AgoraRtmKit.
public protocol RtmClientDelegate: AnyObject {
    /// Called when a message event is received.
    ///
    /// Use this method to receive and handle real-time messages from the AgoraRtmKit.
    ///
    /// - Parameters:
    ///   - rtmClient: The `RtmClientKit` instance that received the message event.
    ///   - event: The ``RtmMessageEvent`` representing the received message event.
    func rtmKit(_ rtmClient: RtmClientKit, didReceiveMessageEvent event: RtmMessageEvent)

    /// Called when a presence event is received.
    ///
    /// Use this method to receive and handle presence events from the AgoraRtmKit.
    ///
    /// - Parameters:
    ///   - rtmClient: The `RtmClientKit` instance that received the presence event.
    ///   - event: The `RtmPresenceEvent` representing the received presence event.
    func rtmKit(_ rtmClient: RtmClientKit, didReceivePresenceEvent event: RtmPresenceEvent)

    /// Called when a lock event is received.
    ///
    /// Use this method to receive and handle lock events from the AgoraRtmKit.
    ///
    /// - Parameters:
    ///   - rtmClient: The `RtmClientKit` instance that received the lock event.
    ///   - event: The `RtmLockEvent` representing the received lock event.
    func rtmKit(_ rtmClient: RtmClientKit, didReceiveLockEvent event: RtmLockEvent)

    /// Called when a storage event is received.
    ///
    /// Use this method to receive and handle storage events from the AgoraRtmKit.
    ///
    /// - Parameters:
    ///   - rtmClient: The `RtmClientKit` instance that received the storage event.
    ///   - event: The `RtmStorageEvent` representing the received storage event.
    func rtmKit(_ rtmClient: RtmClientKit, didReceiveStorageEvent event: RtmStorageEvent)

    /// Called when a topic event is received.
    ///
    /// Use this method to receive and handle topic events from the AgoraRtmKit.
    ///
    /// - Parameters:
    ///   - rtmClient: The `RtmClientKit` instance that received the topic event.
    ///   - event: The `RtmTopicEvent` representing the received topic event.
    func rtmKit(_ rtmClient: RtmClientKit, didReceiveTopicEvent event: RtmTopicEvent)

    /// Called when the token privilege is about to expire.
    ///
    /// Use this method to handle token privilege expiration. You can generate a new token and call the
    /// `renewToken` method to renew the token.
    ///
    /// - Parameters:
    ///   - rtmClient: The `RtmClientKit` instance for which the token privilege will expire.
    ///   - channel: The name of the channel where the token privilege will expire. It can be nil if
    ///              the token privilege applies to the whole app.
    func rtmKit(_ rtmClient: RtmClientKit, tokenPrivilegeWillExpire channel: String?)

    /// Called when the connection state of the `RtmClientKit` changes.
    ///
    /// Use this method to handle changes in the connection state, such as connecting, reconnecting, or disconnection.
    ///
    /// - Parameters:
    ///   - rtmClient: The `RtmClientKit` instance for which the connection state changed.
    ///   - channel: The name of the channel where the connection state changed. It can be nil if
    ///              the connection state applies to the whole app.
    ///   - state: The new connection state of the `RtmClientKit`.
    ///   - reason: The reason for the connection state change.
    func rtmKit(
        _ rtmClient: RtmClientKit, channel: String,
        connectionChangedToState state: RtmClientConnectionState,
        reason: RtmClientConnectionChangeReason
    )
}

protocol DelegateLister: AnyObject {
    var delegateSet: NSHashTable<AnyObject> { get }
    var clientKit: RtmClientKit! { get }
}

extension DelegateLister {
    var clientKit: RtmClientKit! { self as? RtmClientKit }
}

extension RtmClientKit: DelegateLister {}

internal class DelegateProxy: NSObject {
    weak var delegateLister: DelegateLister?

    init(delegateLister: DelegateLister) {
        self.delegateLister = delegateLister
    }
}

// Provide default implementations for optional methods using protocol extensions
public extension RtmClientDelegate {
    func rtmKit(_ rtmClient: RtmClientKit, didReceiveMessageEvent event: RtmMessageEvent) {}
    func rtmKit(_ rtmClient: RtmClientKit, didReceivePresenceEvent event: RtmPresenceEvent) {}
    func rtmKit(_ rtmClient: RtmClientKit, didReceiveLockEvent event: RtmLockEvent) {}
    func rtmKit(_ rtmClient: RtmClientKit, didReceiveStorageEvent event: RtmStorageEvent) {}
    func rtmKit(_ rtmClient: RtmClientKit, didReceiveTopicEvent event: RtmTopicEvent) {}
    func rtmKit(_ rtmClient: RtmClientKit, tokenPrivilegeWillExpire channel: String?) {}
    func rtmKit(
        _ rtmClient: RtmClientKit, channel: String,
        connectionChangedToState state: RtmClientConnectionState,
        reason: RtmClientConnectionChangeReason
    ) {}
}

extension DelegateProxy: AgoraRtmClientDelegate {
    var delegateSet: NSHashTable<AnyObject>? { self.delegateLister?.delegateSet }
    var client: RtmClientKit? { delegateLister?.clientKit }
    public func rtmKit(_ rtmKit: AgoraRtmClientKit, didReceiveMessageEvent event: AgoraRtmMessageEvent) {
        guard let delegateSet, let client, let messageEvent = RtmMessageEvent(event) else { return }
        delegateSet.allObjects.forEach { ($0 as? RtmClientDelegate)?
            .rtmKit(client, didReceiveMessageEvent: messageEvent) }
    }

    public func rtmKit(_ rtmKit: AgoraRtmClientKit, didReceivePresenceEvent event: AgoraRtmPresenceEvent) {
        guard let delegateSet, let client,
              let presenceEvent = RtmPresenceEvent(event)
        else { return }
        delegateSet.allObjects.forEach { ($0 as? RtmClientDelegate)?
            .rtmKit(client, didReceivePresenceEvent: presenceEvent) }
    }

    public func rtmKit(_ rtmKit: AgoraRtmClientKit, didReceiveLockEvent event: AgoraRtmLockEvent) {
        guard let delegateSet, let client else { return }
        delegateSet.allObjects.forEach { ($0 as? RtmClientDelegate)?
            .rtmKit(client, didReceiveLockEvent: RtmLockEvent(event)) }
    }

    public func rtmKit(_ rtmKit: AgoraRtmClientKit, didReceiveStorageEvent event: AgoraRtmStorageEvent) {
        guard let delegateSet, let client else { return }
        delegateSet.allObjects.forEach { ($0 as? RtmClientDelegate)?
            .rtmKit(client, didReceiveStorageEvent: RtmStorageEvent(event)) }
    }

    public func rtmKit(_ rtmKit: AgoraRtmClientKit, didReceiveTopicEvent event: AgoraRtmTopicEvent) {
        guard let delegateSet, let client else { return }
        delegateSet.allObjects.forEach { ($0 as? RtmClientDelegate)?
            .rtmKit(client, didReceiveTopicEvent: RtmTopicEvent(from: event)) }
    }

    public func rtmKit(_ rtmKit: AgoraRtmClientKit, tokenPrivilegeWillExpire channel: String?) {
        guard let delegateSet, let client else { return }
        delegateSet.allObjects.forEach { ($0 as? RtmClientDelegate)?
            .rtmKit(client, tokenPrivilegeWillExpire: channel) }
    }

    public func rtmKit(
        _ kit: AgoraRtmClientKit, channel channelName: String,
        connectionChangedToState state: AgoraRtmClientConnectionState,
        reason: AgoraRtmClientConnectionChangeReason
    ) {
        guard let delegateSet, let client else { return }
        delegateSet.allObjects.forEach {
            ($0 as? RtmClientDelegate)?.rtmKit(
                client, channel: channelName,
                connectionChangedToState: RtmClientConnectionState(rawValue: state.rawValue) ?? .unknown,
                reason: RtmClientConnectionChangeReason(rawValue: reason.rawValue) ?? .unknown
            )
        }
    }
}
