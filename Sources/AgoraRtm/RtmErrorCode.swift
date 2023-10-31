//
//  RtmErrorCode.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

protocol ErrorCode: RawRepresentable where RawValue == Int {}

protocol RtmError: Error {
    associatedtype ErrCode: ErrorCode
    var errorCode: ErrCode { get }
    var rawErrorCode: Int { get }
    var operation: String { get }
    var reason: String { get }
    init?(from errorInfo: AgoraRtmErrorInfo)
    init(errorCode: Int, operation: String, reason: String)
}
extension RtmError {
    init?(from errorInfo: AgoraRtmErrorInfo) {
        if errorInfo.errorCode == .ok {
            return nil
        }
        self.init(errorCode: errorInfo.errorCode.rawValue, operation: errorInfo.operation, reason: errorInfo.reason)
    }
}

/// A base error information struct that implements the `RtmError` protocol,
/// providing error details for the Agora RTM SDK.
public struct RtmErrorInfo: RtmError {
    /// The error code associated with the error.
    public let errorCode: RtmErrorCode

    /// The raw error code value received from the SDK.
    public let rawErrorCode: Int

    /// The name of the operation where the error occurred.
    public let operation: String

    /// The reason or description of the error.
    public let reason: String

    /// Create an `RtmErrorInfo` instance with the specified error code, operation name, and reason.
    ///
    /// - Parameters:
    ///   - errorCode: The error code to associate with the error.
    ///   - operation: The name of the operation where the error occurred.
    ///   - reason: The reason or description of the error.
    internal init(errorCode: Int, operation: String, reason: String) {
        self.errorCode = RtmErrorCode(rawValue: errorCode) ?? .unknown
        self.operation = operation
        self.reason = reason
        self.rawErrorCode = errorCode

        if self.errorCode == .unknown {
            print("Unknown error code: \(errorCode)")
        }
    }

    /// Create an `RtmErrorInfo` instance with the specified error code, operation name, and reason.
    ///
    /// - Parameters:
    ///   - errorCode: The ``RtmErrorCode`` to associate with the error.
    ///   - operation: The name of the operation where the error occurred.
    ///   - reason: The reason or description of the error.
    internal init(errorCode: RtmErrorCode, operation: String, reason: String) {
        self.init(errorCode: errorCode.rawValue, operation: operation, reason: reason)
    }

    /// Create an `RtmErrorInfo` instance for cases where there is no known error,
    /// but the RTM SDK returned no valid response.
    ///
    /// - Parameter operation: The name of the function where the event occurred.
    /// - Returns: A new `RtmErrorInfo` object with the error code set to `-1`.
    internal static func noKnownError(operation: String) -> RtmErrorInfo {
        RtmErrorInfo(
            errorCode: -1,
            operation: operation,
            reason: "\(operation) did not fail or return a response"
        )
    }
}

/// The ``RtmErrorCode`` enum represents error codes for the Agora Signaling (RTM) service.
/// These error codes are used to identify and handle various error scenarios that may occur when
/// using the Agora Signaling service in your application.
public enum RtmErrorCode: Int, ErrorCode {
    // `ok` is not a valid error, absence of an error indicates no error.
//    case ok = 0
    /// Unknown error occurred.
    case unknown = -1
    /// The SDK is not initialized.
    case notInitialized = -10001
    /// The user didn't log in to the Signaling system.
    case notLogin = -10002
    /// The app ID is invalid.
    case invalidAppId = -10003
    /// The event handler is invalid.
    case invalidEventHandler = -10004
    /// The token is invalid.
    case invalidToken = -10005
    /// The user ID is invalid.
    case invalidUserId = -10006
    /// The service is not initialized.
    case initServiceFailed = -10007
    /// The channel name is invalid.
    case invalidChannelName = -10008
    /// The token has expired.
    case tokenExpired = -10009
    /// There are no server resources available.
    case loginNoServerResources = -10010
    /// The login timed out.
    case loginTimeout = -10011
    /// The login was rejected by the server.
    case loginRejected = -10012
    /// The login was aborted due to an unrecoverable error.
    case loginAborted = -10013
    /// The parameter is invalid.
    case invalidParameter = -10014
    /// The login is not authorized.
    ///
    /// Occurs when a user logs in to the Signaling system without being granted permission from the console.
    case loginNotAuthorized = -10015
    /// Trying to login or join with an inconsistent app ID.
    case loginInconsistentAppId = -10016
    /// Already called the same request.
    case duplicateOperation = -10017
    /// Already called destroy or release, this instance is forbidden to call any API. Please create a new instance.
    case instanceAlreadyReleased = -10018
    /// The user has not joined the channel.
    case channelNotJoined = -11001
    /// The user has not subscribed to the channel.
    case channelNotSubscribed = -11002
    /// The topic member count exceeds the limit.
    case channelExceedTopicUserLimitation = -11003
    /// The channel is reused in RTC.
    case channelReused = -11004
    /// The channel instance count exceeds the limit.
    case channelInstanceExceedLimitation = -11005
    /// The channel is in an error state.
    case channelInErrorState = -11006
    /// The channel join failed.
    case channelJoinFailed = -11007
    /// The topic name is invalid.
    case channelInvalidTopicName = -11008
    /// The message is invalid.
    case channelInvalidMessage = -11009
    /// The message length exceeds the limit.
    case channelMessageLengthExceedLimitation = -11010
    /// The user list is invalid.
    case channelInvalidUserList = -11011
    /// The stream channel is not available.
    case channelNotAvailable = -11012
    /// The topic is not subscribed.
    case channelTopicNotSubscribed = -11013
    /// The topic count exceeds the limit.
    case channelExceedTopicLimitation = -11014
    /// Join topic failed.
    case channelJoinTopicFailed = -11015
    /// The topic is not joined.
    case channelTopicNotJoined = -11016
    /// The topic does not exist.
    case channelTopicNotExist = -11017
    /// The topic meta is invalid.
    case channelInvalidTopicMeta = -11018
    /// Subscribe channel timeout.
    case channelSubscribeTimeout = -11019
    /// Subscribe channel too frequently.
    case channelSubscribeTooFrequent = -11020
    /// Subscribe channel failed.
    case channelSubscribeFailed = -11021
    /// Unsubscribe channel failed.
    case channelUnsubscribeFailed = -11022
    /// Encrypt message failed.
    case channelEncryptMessageFailed = -11023
    /// Publish message failed.
    case channelPublishMessageFailed = -11024
    /// Publish message too frequently.
    case channelPublishMessageTooFrequent = -11025
    /// Publish message timeout.
    case channelPublishMessageTimeout = -11026
    /// The connection state is invalid.
    case channelNotConnected = -11027
    /// Leave channel failed.
    case channelLeaveFailed = -11028
    /// The custom type length exceeds the limit.
    case channelCustomTypeLengthOverflow = -11029
    /// The custom type is invalid.
    case channelInvalidCustomType = -11030
    /// Unsupported message type (in macOS/iOS platform, message only supports NSString and NSData).
    case channelUnsupportedMessageType = -11031
    /// The channel presence is not ready.
    case channelPresenceNotReady = -11032
    /// The storage operation failed.
    case storageOperationFailed = -12001
    /// The metadata item count exceeds the limit.
    case storageMetadataItemExceedLimitation = -12002
    /// The metadata item is invalid.
    case storageInvalidMetadataItem = -12003
    /// The argument in the storage operation is invalid.
    case storageInvalidArgument = -12004
    /// The revision in the storage operation is invalid.
    case storageInvalidRevision = -12005
    /// The metadata length exceeds the limit.
    case storageMetadataLengthOverflow = -12006
    /// The lock name in the storage operation is invalid.
    case storageInvalidLockName = -12007
    /// The lock in the storage operation is not acquired.
    case storageLockNotAcquired = -12008
    /// The metadata key is invalid.
    case storageInvalidKey = -12009
    /// The metadata value is invalid.
    case storageInvalidValue = -12010
    /// The metadata key length exceeds the limit.
    case storageKeyLengthOverflow = -12011
    /// The metadata value length exceeds the limit.
    case storageValueLengthOverflow = -12012
    /// The metadata key already exists.
    case storageDuplicateKey = -12013
    /// The revision in the storage operation is outdated.
    case storageOutdatedRevision = -12014
    /// The storage operation performed without subscribing.
    case storageNotSubscribe = -12015
    /// The metadata item is invalid.
    case storageInvalidMetadataInstance = -12016
    /// The user count exceeds the limit when trying to subscribe.
    case storageSubscribeUserExceedLimitation = -12017
    /// The storage operation timeout.
    case storageOperationTimeout = -12018
    /// The storage service is not available.
    case storageNotAvailable = -12019
    /// The user is not connected.
    case presenceNotConnected = -13001
    /// The presence is not writable.
    case presenceNotWritable = -13002
    /// The argument in the presence operation is invalid.
    case presenceInvalidArgument = -13003
    /// The cached presence state count exceeds the limit.
    case presenceCacheTooManyStates = -13004
    /// The state count exceeds the limit.
    case presenceStateCountOverflow = -13005
    /// The state key is invalid.
    case presenceInvalidStateKey = -13006
    /// The state value is invalid.
    case presenceInvalidStateValue = -13007
    /// The state key length exceeds the limit.
    case presenceStateKeySizeOverflow = -13008
    /// The state value length exceeds the limit.
    case presenceStateValueSizeOverflow = -13009
    /// The state key already exists.
    case presenceStateDuplicateKey = -13010
    /// The user is not exist.
    case presenceUserNotExist = -13011
    /// The presence operation timeout.
    case presenceOperationTimeout = -13012
    /// The presence operation failed.
    case presenceOperationFailed = -13013
    /// The lock operation failed.
    case lockOperationFailed = -14001
    /// The lock operation timeout.
    case lockOperationTimeout = -14002
    /// The lock operation is performing.
    case lockOperationPerforming = -14003
    /// The lock already exists.
    case lockAlreadyExist = -14004
    /// The lock name is invalid.
    case lockInvalidName = -14005
    /// The lock is not acquired.
    case lockNotAcquired = -14006
    /// Acquiring the lock failed.
    case lockAcquireFailed = -14007
    /// The lock is not exist.
    case lockNotExist = -14008
    /// The lock service is not available.
    case lockNotAvailable = -14009
}
