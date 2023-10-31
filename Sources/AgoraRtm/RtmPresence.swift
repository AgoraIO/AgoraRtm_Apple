//
//  File.swift
//  
//
//  Created by Max Cobb on 08/08/2023.
//

import AgoraRtmKit

/// Options for querying presence information in the Agora RTM system.
public struct RtmPresenceOptions {

    /// The options to include in the query result.
    public var include: RtmPresenceOptionFeatures

    /// The paging object used for pagination.
    public var page: String

    public init(include: RtmPresenceOptionFeatures = .userId, page: String = "") {
        self.include = include
        self.page = page
    }

    internal var objcVersion: AgoraRtmGetOnlineUsersOptions {
        let objcOpt = AgoraRtmGetOnlineUsersOptions()
        objcOpt.includeUserId = self.include.contains(.userId)
        objcOpt.includeState = self.include.contains(.userState)
        objcOpt.page = self.page
        return objcOpt
    }
}

/// Options to include in the presence query result.
public struct RtmPresenceOptionFeatures: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// Include user ID in the query result.
    public static let userId = RtmPresenceOptionFeatures(rawValue: 1 << 0)

    /// Include user state in the query result.
    public static let userState = RtmPresenceOptionFeatures(rawValue: 1 << 1)

    /// Include both user ID and user state in the query result.
    public static let all: RtmPresenceOptionFeatures = [.userId, .userState]
}

/// Represents options for querying presence information.
public struct RtmPresenceQueryOptions {
    /// The paging object used for pagination.
    public var page: String

    public init(page: String) {
        self.page = page
    }
}

/// Represents a presence management utility for Agora Real-time Messaging SDK.
///
/// Use this class to query the presence information of users in a channel, set user states, and more.
public class RtmPresence {

    internal let presence: AgoraRtmPresence

    internal init?(presence: AgoraRtmPresence?) {
        guard let presence else { return nil }
        self.presence = presence
    }

    /// Queries who has joined the specified channel.
    ///
    /// - Parameters:
    ///   - channel: The type and name of the channel.
    ///   - options: The query option. Default is nil.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmWhoNowResponse, RtmErrorInfo>`.
    public func getOnlineUsers(
        inChannel channel: RtmChannelDetails,
        options: RtmPresenceOptions? = nil,
        completion: @escaping (Result<RtmOnlineUsersResponse, RtmErrorInfo>) -> Void
    ) {
        let (channelName, channelType) = channel.objcVersion
        presence.getOnlineUser(
            channelName: channelName, channelType: channelType,
            options: options?.objcVersion
        ) { response, err in
            CompletionHandlers.handleSyncResult((response, err), completion: completion, operation: #function)
        }
    }

    /// > Renamed: ``getOnlineUsers(inChannel:options:completion:)``
    @available(*, deprecated, renamed: "getOnlineUsers(inChannel:options:completion:)")
    public func whoNow(
        inChannel channel: RtmChannelDetails,
        options: RtmPresenceOptions? = nil,
        completion: @escaping (Result<RtmOnlineUsersResponse, RtmErrorInfo>) -> Void
    ) { self.getOnlineUsers(inChannel: channel, options: options, completion: completion) }

    /// Queries which channels the specified user has joined.
    ///
    /// - Parameters:
    ///   - userId: The ID of the user.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmUserChannelsResponse, RtmErrorInfo>`.
    public func getUserChannels(
        userId: String,
        completion: @escaping (Result<RtmUserChannelsResponse, RtmErrorInfo>) -> Void
    ) {
        presence.getUserChannels(userId: userId) { response, err in
            CompletionHandlers.handleSyncResult((response, err), completion: completion, operation: #function)
        }
    }

    /// > Renamed: ``getUserChannels(userId:completion:)``
    @available(*, deprecated, renamed: "getUserChannels(userId:completion:)")
    public func whereNow(
        userId: String,
        completion: @escaping (Result<RtmUserChannelsResponse, RtmErrorInfo>) -> Void
    ) { self.getUserChannels(userId: userId, completion: completion) }

    /// Sets the local user's state within a specified channel.
    ///
    /// - Parameters:
    ///   - channel: The details of the channel in which the state needs to be set.
    ///   - state: A dictionary containing the states to be set for the local user within the channel.
    ///   - completion: An optional completion handler that returns the result of the state setting operation.
    ///
    /// The method allows the local user to configure their state before subscribing or joining a channel.
    /// Before the user joins or subscribes, the data is merely cached client-side. Once the user joins or
    /// subscribes to the channel, this data becomes active immediately, triggering the appropriate event notifications.
    public func setUserState(
        inChannel channel: RtmChannelDetails,
        to state: [String: String],
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        let (channelName, channelType) = channel.objcVersion
        presence.setState(
            channelName: channelName, channelType: channelType,
            items: state.map {
                let stateItem = AgoraRtmStateItem()
                stateItem.key = $0.key
                stateItem.value = $0.value
                return stateItem
            },
            completion: { resp, err in
                CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
            })
    }

    /// Removes specified state entries of the local user from a given channel.
    ///
    /// - Parameters:
    ///   - channel: The details of the channel from which state entries need to be removed.
    ///   - keys: An array of keys representing the state entries to be removed.
    ///   - completion: An optional callback that returns the result of the state removal operation.
    ///
    /// Use this method to remove specific state entries of the local user from a channel.
    public func removeUserState(
        fromChannel channel: RtmChannelDetails,
        keys: [String],
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        let (channelName, channelType) = channel.objcVersion
        presence.removeState(
            channelName: channelName, channelType: channelType,
            keys: keys, completion: { resp, error in
            CompletionHandlers.handleSyncResult((resp, error), completion: completion, operation: #function)
        })
    }

    /// Gets the user's state.
    ///
    /// - Parameters:
    ///   - userId: The ID of the user.
    ///   - channel: The type and name of the channel.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmPresenceGetStateResponse, RtmErrorInfo>`.
    public func getState(
        ofUser userId: String,
        inChannel channel: RtmChannelDetails,
        completion: @escaping (Result<RtmPresenceGetStateResponse, RtmErrorInfo>) -> Void
    ) {
        let (channelName, channelType) = channel.objcVersion
        presence.getState(
            channelName: channelName, channelType: channelType,
            userId: userId) { response, err in
                CompletionHandlers.handleSyncResult((response, err), completion: completion, operation: #function)
            }
    }
}
