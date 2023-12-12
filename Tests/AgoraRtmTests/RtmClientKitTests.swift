//
//  RtmClientKitTests.swift
//  
//
//  Created by Max Cobb on 14/08/2023.
//

import XCTest
@testable import AgoraRtm
import AgoraRtmKit

@available(iOS 13.0.0, macOS 12.0, *)
final class RtmClientKitTests: XCTestCase {

    var rtmClient: RtmClientKit!

    override func setUpWithError() throws {
        let config = RtmClientConfig(appId: "87654321234567898765432123456789", userId: "yourUserId")
        rtmClient = try RtmClientKit(config: config, delegate: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        rtmClient.logout()
        _ = try? rtmClient?.destroy()
    }

    // Test initialization
    func testInit() {
        XCTAssertNotNil(rtmClient)
        XCTAssertTrue(rtmClient!.delegateSet.allObjects.isEmpty)
    }

    func testLogin() async {
        await executeAndValidateError({
            try await self.rtmClient.login()
        }, errorCode: .invalidToken, source: "\(#function):\(#line)")
    }

    // Test invalid initialization
    func testInvalidAppIdInit() async throws {
        _ = try? rtmClient?.destroy()
        let config = RtmClientConfig(appId: "bad-app-id", userId: "yourUserId")
        await executeAndValidateError({
            try RtmClientKit(config: config, delegate: nil)
        }, errorCode: .invalidAppId, source: "\(#function):\(#line)")
    }

    /// Test `RtmClientKit/setParameters(:)`
    func testSetParams() async {
        await executeAndValidateError({
            try rtmClient.setParameters("test")
        }, errorCode: .invalidParameter, source: "\(#function):\(#line)")
    }

    // Generic function to handle and validate errors from async throwable functions
    func executeAndValidateError<T>(
        _ asyncFunction: () async throws -> T,
        errorCode: RtmErrorCode, source: String
    ) async {
        do {
            _ = try await asyncFunction()
            XCTFail("expecting a failure on asyncFunction. \(source)")
        } catch {
            guard let err = error as? RtmErrorInfo
            else { return XCTFail("invalid error type. \(source)") }
            XCTAssertEqual(err.errorCode, errorCode, "incorrect error code found. \(source)")
        }
    }

    func testCreateStreamChannel() async throws {
        let validChName = "valid-name"
        let invalidChName = "不好"
        await executeAndValidateError({
            try self.rtmClient.createStreamChannel(invalidChName)
        }, errorCode: .invalidChannelName, source: "\(#function):\(#line)")

        let streamChannel = try self.rtmClient.createStreamChannel(validChName)
        XCTAssertEqual(validChName, streamChannel.channelName)

        await executeAndValidateError({
            try await streamChannel.leave()
        }, errorCode: .channelNotJoined, source: "\(#function):\(#line)")
        await executeAndValidateError({
            try await streamChannel.join(with: RtmJoinChannelOption(token: nil))
        }, errorCode: .notLogin, source: "\(#function):\(#line)")
    }
}
