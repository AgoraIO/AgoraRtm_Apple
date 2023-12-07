//
//  File.swift
//  
//
//  Created by Max Cobb on 08/08/2023.
//

import AgoraRtmKit

public enum RtmChannelDetails {
    case none(String)
    case messageChannel(String)
    case streamChannel(String)
    case user(String)
    internal var objcVersion: (channelName: String, channelType: AgoraRtmChannelType) {
        switch self {
        case .none(let name):           (name, .none)
        case .messageChannel(let name): (name, .message)
        case .streamChannel(let name):  (name, .stream)
        case .user(let username):       (username, .user)
        }
    }
    /// Initializes an instance of `RtmChannelInfo`.
    ///
    /// - Parameters:
    ///   - agoraChannelInfo: The `AgoraRtmChannelInfo` instance.
    internal init(_ agoraChannelInfo: AgoraRtmChannelInfo) {
        self = switch agoraChannelInfo.channelType {
        case .message: .messageChannel(agoraChannelInfo.channelName)
        case .stream: .streamChannel(agoraChannelInfo.channelName)
        case .none: .none(agoraChannelInfo.channelName)
        case .user: .user(agoraChannelInfo.channelName)
        @unknown default: .none(agoraChannelInfo.channelName)
        }
    }
}

/// Represents a lock used for synchronization in Agora Real-time Messaging SDK.
public class RtmLock {
    internal let lock: AgoraRtmLock

    /// Initializes a new instance of `RtmLock`.
    /// - Parameter lock: The underlying AgoraRtmLock instance.
    internal init?(lock: AgoraRtmLock?) {
        guard let lock else { return nil }
        self.lock = lock
    }

    /// Sets a lock on a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    ///   - ttl: The lock time-to-live in seconds.
    ///   - completion: A completion block that will be called after the operation completes.
    public func setLock(
        named lockName: String,
        forChannel channel: RtmChannelDetails,
        ttl: Int32,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        let (channelName, channelType) = channel.objcVersion
        lock.setLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName,
            ttl: ttl
        ) { resp, error in
            CompletionHandlers.handleSyncResult((resp, error), completion: completion, operation: #function)
        }
    }

    /// Removes a lock from a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    ///   - completion: A completion block that will be called after the operation completes.
    public func removeLock(
        named lockName: String,
        fromChannel channel: RtmChannelDetails,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        let (channelName, channelType) = channel.objcVersion
        lock.removeLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName
        ) { resp, error in
            CompletionHandlers.handleSyncResult((resp, error), completion: completion, operation: #function)
        }
    }

    /// Acquires a lock on a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    ///   - retry: Whether to automatically retry when acquiring the lock fails.
    ///   - completion: A completion block that will be called after the operation completes.
    public func acquireLock(
        named lockName: String,
        fromChannel channel: RtmChannelDetails,
        retry: Bool = false,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        let (channelName, channelType) = channel.objcVersion
        lock.acquireLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName,
            retry: retry
        ) { resp, error in
            CompletionHandlers.handleSyncResult((resp, error), completion: completion, operation: #function)
        }
    }

    /// Releases a lock on a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    ///   - completion: A completion block that will be called after the operation completes.
    public func releaseLock(
        named lockName: String,
        fromChannel channel: RtmChannelDetails,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        let (channelName, channelType) = channel.objcVersion
        lock.releaseLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName
        ) { resp, error in
            CompletionHandlers.handleSyncResult((resp, error), completion: completion, operation: #function)
        }
    }

    /// Disables a lock on a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    ///   - userId: The user ID of the lock owner.
    ///   - completion: A completion block that will be called after the operation completes.
    public func revokeLock(
        named lockName: String,
        fromChannel channel: RtmChannelDetails,
        userId: String,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        let (channelName, channelType) = channel.objcVersion
        lock.revokeLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName,
            userId: userId
        ) { resp, error in
            CompletionHandlers.handleSyncResult((resp, error), completion: completion, operation: #function)
        }
    }

    /// Gets the locks in a specified channel.
    /// - Parameters:
    ///   - channel: The type and name of the channel.
    ///   - completion: A completion block that will be called with the result.
    public func getLocks(
        forChannel channel: RtmChannelDetails,
        completion: @escaping (Result<RtmGetLocksResponse, RtmErrorInfo>) -> Void
    ) {
        let (channelName, channelType) = channel.objcVersion
        lock.getLocks(channelName: channelName, channelType: channelType) { locks, err in
            CompletionHandlers.handleSyncResult((locks, err), completion: completion, operation: #function)
        }
    }
}
