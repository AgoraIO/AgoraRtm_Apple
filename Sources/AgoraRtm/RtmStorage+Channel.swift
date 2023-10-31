//
//  File.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

extension RtmStorage {
    /// Sets the metadata of a specified channel.
    ///
    /// - Parameters:
    ///   - channelName: The name of the channel.
    ///   - channelType: The channel type, either RTM_CHANNEL_TYPE_STREAM or RTM_CHANNEL_TYPE_MESSAGE.
    ///   - data: The metadata data to be set for the channel.
    ///   - options: The options for operating the metadata. Default is nil.
    ///   - lock: The lock for operating channel metadata. Default is nil.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmCommonResponse, RtmErrorInfo>`.
    public func setMetadata(
        forChannel channel: RtmChannelDetails,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil,
        lock: String? = nil,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        guard let metadata = data.agoraMetadata else {
            completion?(.failure(RtmErrorInfo(
                errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata"
            )))
            return
        }
        let (channelName, channelType) = channel.objcVersion
        storage.setChannelMetadata(
            channelName: channelName, channelType: channelType,
            data: metadata,
            options: options?.objcVersion,
            lock: lock) { resp, err in
                CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
            }
    }

    /// Sets the metadata of a specified channel asynchronously.
    ///
    /// - Parameters:
    ///   - channelName: The name of the channel.
    ///   - channelType: The channel type, either RTM_CHANNEL_TYPE_STREAM or RTM_CHANNEL_TYPE_MESSAGE.
    ///   - data: The metadata data to be set for the channel.
    ///   - options: The options for operating the metadata. Default is nil.
    ///   - lock: The lock for operating channel metadata. Default is nil.
    /// - Throws: If the operation encounters an error, it throws an `RtmErrorInfo`.
    /// - Returns: The operation result, an instance of `RtmCommonResponse`.
    @available(iOS 13.0.0, *) @discardableResult
    public func setMetadata(
        forChannel channel: RtmChannelDetails,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil,
        lock: String? = nil
    ) async throws -> RtmCommonResponse {
        guard let metadata = data.agoraMetadata else {
            throw RtmErrorInfo(errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata")
        }
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(await storage.setChannelMetadata(
            channelName: channelName, channelType: channelType,
            data: metadata,
            options: options?.objcVersion,
            lock: lock
        ), operation: #function)
    }

    /// Updates the metadata of a specified channel.
    ///
    /// - Parameters:
    ///   - channelName: The name of the channel.
    ///   - channelType: The channel type, either RTM_CHANNEL_TYPE_STREAM or RTM_CHANNEL_TYPE_MESSAGE.
    ///   - data: The metadata data to be updated for the channel.
    ///   - options: The options for operating the metadata. Default is nil.
    ///   - lock: The lock for operating channel metadata. Default is nil.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmCommonResponse, RtmErrorInfo>`.
    public func updateMetadata(
        forChannel channel: RtmChannelDetails,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil,
        lock: String? = nil,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        guard let metadata = data.agoraMetadata else {
            completion?(.failure(RtmErrorInfo(
                errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata"
            )))
            return
        }
        let (channelName, channelType) = channel.objcVersion
        let agoraOptions = options?.objcVersion
        storage.updateChannelMetadata(
            channelName: channelName, channelType: channelType,
            data: metadata,
            options: agoraOptions,
            lock: lock,
            completion: { resp, err in
                CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
            })
    }

    /// Updates the metadata of a specified channel asynchronously.
    ///
    /// - Parameters:
    ///   - channelName: The name of the channel.
    ///   - channelType: The channel type, either RTM_CHANNEL_TYPE_STREAM or RTM_CHANNEL_TYPE_MESSAGE.
    ///   - data: The metadata data to be set for the channel.
    ///   - options: The options for operating the metadata. Default is nil.
    ///   - lock: The lock for operating channel metadata. Default is nil.
    /// - Returns: On success, it returns ``RtmCommonResponse``. On failure, it throws ``RtmErrorInfo``.
    @available(iOS 13.0.0, *) @discardableResult
    public func updateMetadata(
        forChannel channel: RtmChannelDetails,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil,
        lock: String? = nil
    ) async throws -> RtmCommonResponse {
        guard let metadata = data.agoraMetadata else {
            throw RtmErrorInfo(errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata")
        }
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(await storage.updateChannelMetadata(
            channelName: channelName, channelType: channelType,
            data: metadata,
            options: options?.objcVersion,
            lock: lock
        ), operation: #function)
    }

    /// Removes the metadata of a specified channel.
    ///
    /// - Parameters:
    ///   - channelName: The name of the channel.
    ///   - channelType: The channel type, either RTM_CHANNEL_TYPE_STREAM or RTM_CHANNEL_TYPE_MESSAGE.
    ///   - data: The metadata data to be removed from the channel.
    ///   - options: The options for operating the metadata. Default is nil.
    ///   - lock: The lock for operating channel metadata. Default is nil.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmCommonResponse, RtmErrorInfo>`.
    public func removeMetadata(
        fromChannel channel: RtmChannelDetails,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil,
        lock: String? = nil,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        guard let metadata = data.agoraMetadata else {
            completion?(.failure(RtmErrorInfo(
                errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata"
            )))
            return
        }
        let (channelName, channelType) = channel.objcVersion
        let agoraOptions = options?.objcVersion
        storage.removeChannelMetadata(
            channelName: channelName, channelType: channelType,
            data: metadata,
            options: agoraOptions,
            lock: lock,
            completion: { resp, err in
                CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
            })
    }

    /// Removes the metadata of a specified channel asynchronously.
    ///
    /// - Parameters:
    ///   - channelName: The name of the channel.
    ///   - channelType: The channel type, either RTM_CHANNEL_TYPE_STREAM or RTM_CHANNEL_TYPE_MESSAGE.
    ///   - data: The metadata data to be removed from the channel.
    ///   - options: The options for operating the metadata. Default is nil.
    ///   - lock: The lock for operating channel metadata. Default is nil.
    /// - Returns: On success, it returns ``RtmCommonResponse``.
    ///            On failure, it throws ``RtmErrorInfo``.
    @available(iOS 13.0.0, *) @discardableResult
    public func removeMetadata(
        fromChannel channel: RtmChannelDetails,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil,
        lock: String? = nil
    ) async throws -> RtmCommonResponse {
        guard let metadata = data.agoraMetadata else {
            throw RtmErrorInfo(
                errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata"
            )
        }
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(await storage.removeChannelMetadata(
            channelName: channelName, channelType: channelType,
            data: metadata,
            options: options?.objcVersion,
            lock: lock
        ), operation: #function)
    }

    /// Retrieves the metadata of a specified channel.
    ///
    /// - Parameters:
    ///   - channelName: The name of the channel.
    ///   - channelType: The channel type, either RTM_CHANNEL_TYPE_STREAM or RTM_CHANNEL_TYPE_MESSAGE.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmGetMetadataResponse, RtmErrorInfo>`.
    public func getMetadata(
        forChannel channel: RtmChannelDetails,
        completion: @escaping (Result<RtmGetMetadataResponse, RtmErrorInfo>) -> Void
    ) {
        let (channelName, channelType) = channel.objcVersion
        storage.getChannelMetadata(
            channelName: channelName, channelType: channelType
        ) { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        }
    }

    /// Gets the metadata of a specified channel asynchronously.
    ///
    /// - Parameters:
    ///   - channel: The type and name of the channel.
    /// - Returns: A `Result` indicating the operation's success or failure. On success, it contains
    ///            an optional ``RtmGetMetadataResponse``. On failure, it contains `RtmErrorInfo`.
    @available(iOS 13.0.0, *)
    public func getMetadata(
        forChannel channel: RtmChannelDetails
    ) async throws -> RtmGetMetadataResponse {
        let (channelName, channelType) = channel.objcVersion
        return try CompletionHandlers.handleAsyncThrow(await storage.getChannelMetadata(
            channelName: channelName, channelType: channelType
        ), operation: #function)
    }

}
