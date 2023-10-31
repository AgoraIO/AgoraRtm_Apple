//
//  File.swift
//  
//
//  Created by Max Cobb on 08/08/2023.
//

import AgoraRtmKit

@available(iOS 13.0, *)
extension RtmLock {
    /// Asynchronously sets a lock on a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    ///   - ttl: The lock time-to-live in seconds.
    /// - Returns: A ``RtmCommonResponse`` object the query response or an error.
    @discardableResult
    public func setLock(
        named lockName: String,
        forChannel channel: RtmChannelDetails,
        ttl: Int32
    ) async throws -> RtmCommonResponse {
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(await self.lock.setLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName,
            ttl: ttl
        ), operation: #function)
    }

    /// Asynchronously removes a lock from a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    /// - Returns: A ``RtmCommonResponse`` object the query response or an error.
    @discardableResult
    public func removeLock(
        named lockName: String,
        fromChannel channel: RtmChannelDetails
    ) async throws -> RtmCommonResponse {
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(await self.lock.removeLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName
        ), operation: #function)
    }

    /// Asynchronously acquires a lock on a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    ///   - retry: Whether to automatically retry when acquiring the lock fails.
    /// - Returns: A ``RtmCommonResponse`` object the query response or an error.
    @discardableResult
    public func acquireLock(
        named lockName: String,
        fromChannel channel: RtmChannelDetails,
        retry: Bool = false
    ) async throws -> RtmCommonResponse {
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(await self.lock.acquireLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName,
            retry: retry
        ), operation: #function)
    }

    /// Asynchronously releases a lock on a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    /// - Returns: A ``RtmCommonResponse`` object the query response or an error.
    @discardableResult
    public func releaseLock(
        named lockName: String,
        fromChannel channel: RtmChannelDetails
    ) async throws -> RtmCommonResponse {
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(await self.lock.releaseLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName
        ), operation: #function)
    }

    /// Asynchronously disables a lock on a specified channel.
    /// - Parameters:
    ///   - lockName: The name of the lock.
    ///   - channel: The type and name of the channel.
    ///   - userId: The user ID of the lock owner.
    /// - Returns: A ``RtmCommonResponse`` object the query response or an error.
    @discardableResult
    public func revokeLock(
        named lockName: String,
        fromChannel channel: RtmChannelDetails,
        userId: String
    ) async throws -> RtmCommonResponse {
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(await self.lock.revokeLock(
            channelName: channelName, channelType: channelType,
            lockName: lockName,
            userId: userId
        ), operation: #function)
    }

    /// Asynchronously gets the locks in a specified channel.
    /// - Parameters:
    ///   - channel: The type and name of the channel.
    /// - Returns: A ``RtmGetLocksResponse`` object the query response or an error.
    public func getLocks(
        forChannel channel: RtmChannelDetails
    ) async throws -> RtmGetLocksResponse {
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(
            await self.lock.getLocks(channelName: channelName, channelType: channelType),
            operation: #function
        )
    }
}
