//
//  RtmStreamChannel.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// A class providing convenient methods
/// to interact with the stream channels in the Agora Signaling SDK.
open class RtmStreamChannel: NSObject {
    private let channel: AgoraRtmStreamChannel

    /// The name of the stream channel.
    public var channelName: String { channel.getChannelName() }

    /// Initializes an ``RtmStreamChannel`` instance with the specified `AgoraRtmStreamChannel`.
    ///
    /// - Parameter channel: The `AgoraRtmStreamChannel` to wrap. Pass `nil` to create
    ///                      an `RtmStreamChannel` instance with no underlying channel.
    internal init?(channel: AgoraRtmStreamChannel?) {
        guard let channel else { return nil }
        self.channel = channel
        super.init()
    }

    /// Joins the stream channel with the provided `RtmJoinChannelOption`.
    ///
    /// - Parameters:
    ///   - option: The ``RtmJoinChannelOption`` to use for joining the channel.
    ///   - completion: An optional completion block that will be called with the result of the operation.
    ///                 The result will contain either a successful ``RtmCommonResponse``
    ///                 or an error of type ``RtmErrorInfo``.
    public func join(
        with option: RtmJoinChannelOption,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        channel.join(option.objcVersion) { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        }
    }

    /// Asynchronously joins a channel with specified options.
    ///
    /// Use this method to join a channel with the desired settings,
    /// allowing more granular control over channel behavior.
    ///
    /// - Parameter option: The configuration options for joining the channel,
    ///                     encapsulated in an ``RtmJoinChannelOption`` object.
    ///
    /// - Throws: ``RtmErrorInfo`` if an error occurs during the join attempt.
    ///
    /// - Returns: A response confirming the result of the join attempt,
    ///            currently an ``RtmCommonResponse`` object.
    @available(iOS 13.0.0, *) @discardableResult
    public func join(
        with option: RtmJoinChannelOption
    ) async throws -> RtmCommonResponse {
        return try CompletionHandlers.handleAsyncThrow(
            await channel.join(option.objcVersion), operation: #function
        )
    }

    /// Leaves the stream channel.
    ///
    /// - Parameter completion: An optional completion block that will be called with the result of the operation.
    ///                         The result will contain either a successful ``RtmCommonResponse``
    ///                         or an error of type ``RtmErrorInfo``.
    public func leave(
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        channel.leave { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        }
    }

    @available(iOS 13.0.0, *) @discardableResult
    public func leave() async throws -> RtmCommonResponse {
        return try CompletionHandlers.handleAsyncThrow(await channel.leave(), operation: #function)
    }

    /// Renews the token for the stream channel.
    ///
    /// - Parameters:
    ///   - token: The new token to renew.
    ///   - completion: An optional completion block that will be called with the result of the operation.
    ///                 The result will contain either a successful ``RtmCommonResponse``
    ///                 or an error of type `RtmErrorInfo`.
    public func renewToken(
        _ token: String,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        channel.renewToken(token, completion: { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        })
    }

    @available(iOS 13.0.0, *) @discardableResult
    public func renewToken(_ token: String) async throws -> RtmCommonResponse {
        return try CompletionHandlers.handleAsyncThrow(await channel.renewToken(token), operation: #function)
    }

    /// Joins the stream channel with the provided ``RtmJoinChannelOption``.
    ///
    /// - Parameters:
    ///   - topic: The name of the stream channel to join.
    ///   - option: The ``RtmJoinTopicOption`` to use for joining the channel.
    ///   - completion: An optional completion block that will be called with the result of the operation.
    ///                 The result will contain either a successful `RtmCommonResponse`
    ///                 or an error of type `RtmErrorInfo`.
    public func joinTopic(
        _ topic: String, with option: RtmJoinTopicOption? = nil,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        channel.joinTopic(topic, option: option?.objcVersion, completion: { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        })
    }

    /// Asynchronously joins the stream channel with the provided ``RtmJoinTopicOption``.
    ///
    /// - Parameters:
    ///   - topic: The name of the stream channel to join.
    ///   - option: The ``RtmJoinTopicOption`` to use for joining the channel.
    /// - Returns: A ``RtmCommonResponse`` object representing the result of the operation.
    /// - Throws: An error of type ``RtmErrorInfo`` if the operation fails.
    @available(iOS 13.0.0, *) @discardableResult
    public func joinTopic(
        _ topic: String, with option: RtmJoinTopicOption? = nil
    ) async throws -> RtmCommonResponse {
        return try CompletionHandlers.handleAsyncThrow(
            await channel.joinTopic(topic, option: option?.objcVersion),
            operation: #function
        )
    }

    /// Leaves the stream channel.
    ///
    /// - Parameters:
    ///   - topic: The name of the stream channel to leave.
    ///   - completion: An optional completion block that will be called with the result of the operation.
    ///                 The result will contain either a successful ``RtmCommonResponse``
    ///                 or an error of type ``RtmErrorInfo``.
    public func leaveTopic(
        _ topic: String,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        channel.leaveTopic(topic, completion: { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        })
    }

    /// Asynchronously leaves the stream channel.
    ///
    /// - Parameter topic: The name of the stream channel to leave.
    /// - Returns: A ``RtmCommonResponse`` object representing the result of the operation.
    /// - Throws: An error of type ``RtmErrorInfo`` if the operation fails.
    @available(iOS 13.0.0, *) @discardableResult
    public func leaveTopic(
        _ topic: String
    ) async throws -> RtmCommonResponse {
        return try CompletionHandlers.handleAsyncThrow(await channel.leaveTopic(topic), operation: #function)
    }

    /// Subscribes to messages from specified users within a topic.
    ///
    /// This method lets you receive messages from a list of specific users in a given topic.
    ///
    /// - Parameters:
    ///   - topic: The topic name to be subscribed to.
    ///   - options: Subscription options using ``RtmTopicOption``, including users to subscribe to.
    ///              Use `nil` to subscribe to all.
    ///   - completion: An optional completion handler that returns either a successful response
    ///                 (``RtmTopicSubscriptionResponse``) or an error (``RtmErrorInfo``). Defaults to nil.
    public func subscribe(
        toTopic topic: String, withOptions options: RtmTopicOption? = nil,
        completion: ((Result<RtmTopicSubscriptionResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        channel.subscribeTopic(topic, option: options?.objcVersion, completion: { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        })
    }

    /// Asynchronously subscribes to messages from specified users within a topic.
    ///
    /// - Parameters:
    ///   - topic: The topic name to be subscribed to.
    ///   - options: Subscription options using ``RtmTopicOption``, including users to subscribe to.
    ///              Use `nil` to subscribe to all.
    ///
    /// - Returns:
    ///   A result that either provides a successful response ``RtmTopicSubscriptionResponse``
    ///   or throws an error ``RtmErrorInfo``.
    @discardableResult @available(iOS 13.0.0, *)
    public func subscribe(
        toTopic topic: String, withOptions options: RtmTopicOption? = nil
    ) async throws -> RtmTopicSubscriptionResponse {
        return try CompletionHandlers.handleAsyncThrow(
            await channel.subscribeTopic(topic, option: options?.objcVersion),
            operation: #function
        )
    }

    /// Unsubscribes from specified users' messages within a topic.
    ///
    /// This method allows you to stop receiving messages from a list of specified users within a given topic.
    ///
    /// - Parameters:
    ///   - topic: The topic name to be unsubscribed from.
    ///   - options: Subscription options using ``RtmTopicOption``, including users to unsubscribe to.
    ///              Use `nil` to unsubscribe to all.
    ///   - completion: An optional completion handler that returns either a successful response ``RtmCommonResponse``
    ///                 or an error ``RtmErrorInfo``.
    public func unsubscribe(
        fromTopic topic: String, withOptions options: RtmTopicOption? = nil,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        channel.unsubscribeTopic(topic, option: options?.objcVersion, completion: { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        })
    }

    /// Asynchronously unsubscribes from messages from specified users within a topic.
    ///
    /// - Parameters:
    ///   - topic: The topic name to be unsubscribed from.
    ///   - options: Subscription options using ``RtmTopicOption``, including users to unsubscribe to.
    ///              Use `nil` to unsubscribe to all.
    ///
    /// - Returns:
    ///   A result that either provides a successful response ``RtmCommonResponse``
    ///   or throws an error ``RtmErrorInfo``.
    @available(iOS 13.0.0, *) @discardableResult
    public func unsubscribe(
        fromTopic topic: String, withOptions options: RtmTopicOption? = nil
    ) async throws -> RtmCommonResponse {
        return try CompletionHandlers.handleAsyncThrow(
            await channel.unsubscribeTopic(topic, option: options?.objcVersion),
            operation: #function
        )
    }

    /// Publishes a message to a specified topic asynchronously.
    ///
    /// - Parameters:
    ///   - message: The message to be published. Must be `Codable`.
    ///   - topic: The name of the topic to which the message will be published.
    ///   - options: Optional configurations for publishing the message to a topic. Defaults to `nil`.
    ///   - completion: A completion block that returns a result containing an ``RtmCommonResponse``
    ///                 or ``RtmErrorInfo``.
    public func publishTopicMessage(
        _ message: Codable, in topic: String, with options: RtmTopicMessageOptions?,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        let msgString: String
        do {
            msgString = try message.convertToString()
        } catch let error as RtmErrorInfo {
            completion?(.failure(error))
            return
        } catch {
            completion?(.failure(RtmErrorInfo(
                errorCode: .channelInvalidMessage, operation: #function,
                reason: "could not encode message: \(error.localizedDescription)"
            )))
            return
        }
        channel.publishTopicMessage(
            topic: topic,
            message: msgString,
            option: options?.objcVersion,
            completion: { resp, err in
                CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
            }
        )
    }

    /// Publishes a message to a specified topic.
    ///
    /// This function allows you to publish a message to a topic.
    ///
    /// - Parameters:
    ///   - message: The message to be published. Must be `Codable`.
    ///   - topic: The name of the topic to which the message will be published.
    ///   - options: Optional configurations for publishing the message to a topic. Defaults to `nil`.
    ///
    /// - Returns: An ``RtmCommonResponse`` containing information about the published message.
    ///
    /// - Throws: ``RtmErrorInfo`` if an error occurs during the publishing process.
    @available(iOS 13.0.0, *) @discardableResult
    public func publishTopicMessage(
        message: Codable,
        inTopic topic: String, with options: RtmTopicMessageOptions?
    ) async throws -> RtmCommonResponse {
        let msgString: String
        do {
            msgString = try message.convertToString()
        } catch let error as RtmErrorInfo {
            throw error
        } catch {
            throw RtmErrorInfo(
                errorCode: .channelInvalidMessage, operation: #function,
                reason: "could not encode message: \(error.localizedDescription)"
            )
        }
        return try CompletionHandlers.handleAsyncThrow(await channel.publishTopicMessage(
            topic: topic, message: msgString, option: options?.objcVersion
        ), operation: #function)
    }

    /// Retrieves the list of subscribed users from a stream channel.
    ///
    /// - Parameters:
    ///   - topic: The name of the stream channel to retrieve the list of subscribed users from.
    ///   - completion: An optional completion block that will be called with the result of the operation.
    ///                 The result will contain either a successful array of user IDs
    ///                 or an error of type ``RtmErrorInfo``.
    public func getSubscribedUserList(
        forTopic topic: String,
        completion: ((Result<[String], RtmErrorInfo>) -> Void)? = nil
    ) {
        channel.getSubscribedUserList(topic, completion: { resp, err in
            guard let completion = completion else { return }
            if let err = RtmErrorInfo(from: err) { return completion(.failure(err)) }
            guard let resp = resp else {
                return completion(.failure(RtmErrorInfo.noKnownError(operation: #function)))
            }
            completion(.success(resp.users))
        })
    }

    /// Asynchronously retrieves the list of subscribed users from a stream channel.
    ///
    /// - Parameter topic: The name of the stream channel to retrieve the list of subscribed users from.
    /// - Returns: An array of user IDs representing the list of subscribed users.
    /// - Throws: An error of type ``RtmErrorInfo`` if the operation fails.
    @available(iOS 13.0.0, *)
    public func getSubscribedUserList(
        forTopic topic: String
    ) async throws -> [String] {
        let (resp, err) = await channel.getSubscribedUserList(topic)
        if let err = RtmErrorInfo(from: err) { throw err }
        guard let resp = resp else { throw RtmErrorInfo.noKnownError(operation: #function) }
        return resp.users
    }

    /// Destroys the stream channel.
    ///
    /// - Returns: The error code associated with the destruction of the channel,
    ///            or `nil` if the destruction is successful.
    func destroy() -> RtmErrorCode? {
        let destroyCode = channel.destroy()
        if destroyCode == .ok { return nil }
        return .init(rawValue: destroyCode.rawValue)
    }
}

/// Options for subscribing and unsubscribing to a topic
@objc public class RtmTopicOption: NSObject {
    /// The list of users to subscribe to or unsubscribe from.
    /// Use `nil` to apply to all users in a topic
    @objc public var users: [String]?
    /// Fetches the Objective-C version of the `AgoraRtmTopicOption`.
    internal var objcVersion: AgoraRtmTopicOption {
        let objcOpt = AgoraRtmTopicOption()
        objcOpt.users = self.users
        return objcOpt
    }

    /// Creates an instance of ``RtmTopicOption`` with the provided parameters.
    /// - Parameter users: The list of users to subscribe to or unsubscribe from.
    ///                    Use `nil` to apply to all users in a topic
    @objc public init(users: [String]? = nil) {
        self.users = users
    }
}
