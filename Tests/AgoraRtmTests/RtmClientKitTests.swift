//
//  RtmClientKitTests.swift
//  
//
//  Created by Max Cobb on 14/08/2023.
//

import XCTest
@testable import AgoraRtm
import AgoraRtmKit

@available(iOS 13.0.0, *)
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
        do {
            try await rtmClient.login()
            XCTFail("expected login to fail")
        } catch {
            guard let rtmError = error as? RtmErrorInfo else {
                XCTFail("expected RtmErrorInfo, but got \(error)")
                return
            }
            XCTAssertEqual(rtmError.errorCode, .invalidToken)
        }
    }

    // Test invalid initialization
    func testInvalidAppIdInit() throws {
        _ = try? rtmClient?.destroy()
//        XCTAssertNil(rtmClient.agoraRtmClient)
        let config = RtmClientConfig(appId: "bad-app-id", userId: "yourUserId")
        let expectation = XCTestExpectation(description: "Error thrown")
        XCTAssertThrowsError(try RtmClientKit(config: config, delegate: nil)) { error in
            if let error = error as? RtmErrorInfo {
                XCTAssertEqual(error.errorCode, .invalidAppId)
            } else {
                XCTFail("Expected RtmErrorInfo but got \(type(of: error))")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    /// Test `RtmClientKit/setParameters(:)`
    func testSetParams() {
        let expectation = XCTestExpectation(description: "Error thrown")
        XCTAssertThrowsError(try rtmClient.setParameters("test"), "Invalid thrown response") { error in
            if let error = error as? RtmErrorInfo {
                XCTAssertEqual(error.errorCode, .invalidParameter)
            } else {
                XCTFail("Expected RtmErrorInfo but got \(type(of: error))")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
