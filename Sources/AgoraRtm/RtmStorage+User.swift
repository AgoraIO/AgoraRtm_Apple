//
//  File.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

extension RtmStorage {
    /// Sets the metadata of a specified user.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    ///   - data: The metadata data to be set for the user.
    ///   - options: The options for operating the metadata. Default is nil.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmCommonResponse, RtmErrorInfo>`.
    public func setMetadata(
        forUser userId: String,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        guard let metadata = data.agoraMetadata else {
            completion?(.failure(RtmErrorInfo(
                errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata")
            ))
            return
        }
        let agoraOptions = options?.objcVersion
        storage.setUserMetadata(
            userId: userId,
            data: metadata,
            options: agoraOptions,
            completion: { resp, err in
                CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
            }
        )
    }

    /// Sets the metadata of a specified user asynchronously.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    ///   - data: The metadata data to be set for the user.
    ///   - options: The options for operating the metadata. Default is nil.
    /// - Returns: On success, it returns ``RtmCommonResponse``.
    ///            On failure, it throws ``RtmErrorInfo``.
    @available(iOS 13.0.0, macOS 12.0, *) @discardableResult
    public func setMetadata(
        forUser userId: String,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil
    ) async throws -> RtmCommonResponse {
        guard let metadata = data.agoraMetadata else {
            throw RtmErrorInfo(
                errorCode: .storageInvalidMetadataItem,
                operation: #function, reason: "bad metadata"
            )
        }
        return try CompletionHandlers.handleAsyncThrow(await storage.setUserMetadata(
            userId: userId,
            data: metadata,
            options: options?.objcVersion
        ), operation: #function)
    }

    /// Updates the metadata of a specified user.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    ///   - data: The metadata data to be updated for the user.
    ///   - options: The options for operating the metadata. Default is nil.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmCommonResponse, RtmErrorInfo>`.
    public func updateMetadata(
        forUser userId: String,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        guard let metadata = data.agoraMetadata else {
            completion?(.failure(RtmErrorInfo(
                errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata")
            ))
            return
        }
        let agoraOptions = options?.objcVersion
        storage.updateUserMetadata(
            userId: userId,
            data: metadata,
            options: agoraOptions,
            completion: { resp, err in
                CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
            })
    }

    /// Updates the metadata of a specified user asynchronously.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    ///   - data: The metadata data to be updated for the user.
    ///   - options: The options for operating the metadata. Default is nil.
    /// - Returns: On success, it returns `RtmCommonResponse`.
    ///            On failure, it throws `RtmErrorInfo`.
    @available(iOS 13.0.0, macOS 12.0, *) @discardableResult
    public func updateMetadata(
        forUser userId: String,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil
    ) async throws -> RtmCommonResponse {
        guard let metadata = data.agoraMetadata else {
            throw RtmErrorInfo(errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata")
        }
        return try CompletionHandlers.handleAsyncThrow(await storage.updateUserMetadata(
            userId: userId,
            data: metadata,
            options: options?.objcVersion
        ), operation: #function)
    }

    /// Removes the metadata of a specified user.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    ///   - data: The metadata data to be removed from the user.
    ///   - options: The options for operating the metadata. Default is nil.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmCommonResponse, RtmErrorInfo>`.
    public func removeMetadata(
        forUser userId: String,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        guard let metadata = data.agoraMetadata else {
            completion?(.failure(RtmErrorInfo(
                errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata")
            ))
            return
        }
        let agoraOptions = options?.objcVersion
        storage.removeUserMetadata(
            userId: userId,
            data: metadata,
            options: agoraOptions,
            completion: { resp, err in
                CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
            })
    }

    /// Removes the metadata of a specified user asynchronously.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    ///   - data: The metadata data to be removed from the user.
    ///   - options: The options for operating the metadata. Default is nil.
    /// - Returns: On success, it returns `RtmCommonResponse`.
    ///            On failure, it throws `RtmErrorInfo`.
    @available(iOS 13.0.0, macOS 12.0, *) @discardableResult
    public func removeMetadata(
        forUser userId: String,
        data: RtmMetadata,
        options: RtmMetadataOptions? = nil
    ) async throws -> RtmCommonResponse {
        guard let metadata = data.agoraMetadata else {
            throw RtmErrorInfo(errorCode: .storageInvalidMetadataItem, operation: #function, reason: "bad metadata")
        }
        return try CompletionHandlers.handleAsyncThrow(await storage.removeUserMetadata(
            userId: userId,
            data: metadata,
            options: options?.objcVersion
        ), operation: #function)
    }

    /// Retrieves the metadata of a specified user.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmGetMetadataResponse, RtmErrorInfo>`.
    public func getMetadata(
        forUser userId: String,
        completion: @escaping (Result<RtmGetMetadataResponse, RtmErrorInfo>) -> Void
    ) {
        storage.getUserMetadata(userId: userId) { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        }
    }

    /// Gets the metadata of a specified user asynchronously.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    /// - Returns: On success, it returns ``RtmGetMetadataResponse``.
    ///            On failure, throws ``RtmErrorInfo``.
    @available(iOS 13.0.0, macOS 12.0, *)
    public func getMetadata(
        forUser userId: String
    ) async throws -> RtmGetMetadataResponse {
        return try CompletionHandlers.handleAsyncThrow(
            await storage.getUserMetadata(userId: userId), operation: #function
        )
    }

    /// Subscribes to the metadata update event of a specified user.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmCommonResponse, RtmErrorInfo>`.
    public func subscribeToMetadata(
        forUser userId: String,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        storage.subscribeUserMetadata(userId: userId) { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        }
    }

    /// Subscribes to the metadata update event of a specified user asynchronously.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    /// - Returns: On success, it returns ``RtmCommonResponse``.
    ///            On failure, it throws ``RtmErrorInfo``.
    @available(iOS 13.0.0, macOS 12.0, *) @discardableResult
    public func subscribeToMetadata(
        forUser userId: String
    ) async throws -> RtmCommonResponse {
        return try CompletionHandlers.handleAsyncThrow(
            await storage.subscribeUserMetadata(userId: userId),
            operation: #function
        )
    }

    /// Unsubscribes from the metadata update event of a specified user.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    ///   - completion: The completion handler to be called with the operation result,
    ///                 `Result<RtmCommonResponse, RtmErrorInfo>`.
    public func unsubscribeFromMetadata(
        forUser userId: String,
        completion: ((Result<RtmCommonResponse, RtmErrorInfo>) -> Void)? = nil
    ) {
        storage.unsubscribeUserMetadata(userId: userId) { resp, err in
            CompletionHandlers.handleSyncResult((resp, err), completion: completion, operation: #function)
        }
    }

    /// Unsubscribes from the metadata update event of a specified user asynchronously.
    ///
    /// - Parameters:
    ///   - userId: The user ID of the specified user.
    /// - Returns: On success, it returns ``RtmCommonResponse``.
    ///            On failure, it throws ``RtmErrorInfo``.
    @available(iOS 13.0.0, macOS 12.0, *) @discardableResult
    public func unsubscribeFromMetadata(
        forUser userId: String
    ) async throws -> RtmCommonResponse {
        return try CompletionHandlers.handleAsyncThrow(
            await storage.unsubscribeUserMetadata(userId: userId),
            operation: #function
        )
    }

}
