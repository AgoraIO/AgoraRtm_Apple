//
//  RtmErrorTests.swift
//  
//
//  Created by Max Cobb on 12/09/2023.
//

import XCTest
@testable import AgoraRtm
import AgoraRtmKit

final class RtmErrorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllErrorCodes() {
        print(RtmClientKit.getVersion())
        for enumVal in RtmErrorCode.allCases {
            if enumVal == .unknown {
                XCTAssertEqual(
                    RtmClientKit.getErrorReason(enumVal), "Unknown error happened",
                    "Unknown error message changed: \(enumVal.rawValue)"
                )
            } else {
                XCTAssertNotEqual(
                    RtmClientKit.getErrorReason(enumVal), "Unknown error happened",
                    "Error could not be found: \(enumVal.rawValue)"
                )
            }
        }
    }
}

extension RtmErrorCode: CaseIterable {
    // swiftlint:disable:next line_length
    public static var allCases: [RtmErrorCode] = [.unknown, .notInitialized, .notLogin, .invalidAppId, .invalidEventHandler, .invalidToken, .invalidUserId, .initServiceFailed, .invalidChannelName, .tokenExpired, .loginNoServerResources, .loginTimeout, .loginRejected, .loginAborted, .invalidParameter, .loginNotAuthorized, .loginInconsistentAppId, .duplicateOperation, .instanceAlreadyReleased, .channelNotJoined, .channelNotSubscribed, .channelExceedTopicUserLimitation, .channelReused, .channelInstanceExceedLimitation, .channelInErrorState, .channelJoinFailed, .channelInvalidTopicName, .channelInvalidMessage, .channelMessageLengthExceedLimitation, .channelInvalidUserList, .channelNotAvailable, .channelTopicNotSubscribed, .channelExceedTopicLimitation, .channelJoinTopicFailed, .channelTopicNotJoined, .channelTopicNotExist, .channelInvalidTopicMeta, .channelSubscribeTimeout, .channelSubscribeTooFrequent, .channelSubscribeFailed, .channelUnsubscribeFailed, .channelEncryptMessageFailed, .channelPublishMessageFailed, .channelPublishMessageTooFrequent, .channelPublishMessageTimeout, .channelNotConnected, .channelLeaveFailed, .channelCustomTypeLengthOverflow, .channelInvalidCustomType, .channelUnsupportedMessageType, .channelPresenceNotReady, .storageOperationFailed, .storageMetadataItemExceedLimitation, .storageInvalidMetadataItem, .storageInvalidArgument, .storageInvalidRevision, .storageMetadataLengthOverflow, .storageInvalidLockName, .storageLockNotAcquired, .storageInvalidKey, .storageInvalidValue, .storageKeyLengthOverflow, .storageValueLengthOverflow, .storageDuplicateKey, .storageOutdatedRevision, .storageNotSubscribe, .storageInvalidMetadataInstance, .storageSubscribeUserExceedLimitation, .storageOperationTimeout, .storageNotAvailable, .presenceNotConnected, .presenceNotWritable, .presenceInvalidArgument, .presenceCacheTooManyStates, .presenceStateCountOverflow, .presenceInvalidStateKey, .presenceInvalidStateValue, .presenceStateKeySizeOverflow, .presenceStateValueSizeOverflow, .presenceStateDuplicateKey, .presenceUserNotExist, .presenceOperationTimeout, .presenceOperationFailed, .lockOperationFailed, .lockOperationTimeout, .lockOperationPerforming, .lockAlreadyExist, .lockInvalidName, .lockNotAcquired, .lockAcquireFailed, .lockNotExist, .lockNotAvailable]
}
