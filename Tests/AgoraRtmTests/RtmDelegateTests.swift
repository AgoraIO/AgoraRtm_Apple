//
//  RtmDelegateTests.swift
//  
//
//  Created by Max Cobb on 30/08/2023.
//

import XCTest
@testable import AgoraRtm
import AgoraRtmKit

final class RtmDelegateTests: XCTestCase {

    var rtmClient: RtmClientKit!

    override func setUpWithError() throws {
        let config = RtmClientConfig(appId: "87654321234567898765432123456789", userId: "yourUserId")
        rtmClient = try RtmClientKit(config: config, delegate: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        _ = try? rtmClient?.destroy()
    }

    func testDelegateCalling() {
        let expectation = XCTestExpectation(description: "delegate method called")
        let newDele = DelegateExample(expectation: expectation)
        rtmClient.addDelegate(newDele)
        rtmClient.delegateProxy.rtmKit(
            rtmClient.agoraRtmClient, channel: "test",
            connectionChangedToState: .connected, reason: .changedEchoTest
        )
        wait(for: [expectation], timeout: 0.1)
    }
}

class DelegateExample: RtmClientDelegate {
    func rtmKit(
        _ rtmClient: RtmClientKit, channel: String,
        connectionChangedToState state: RtmClientConnectionState,
        reason: RtmClientConnectionChangeReason
    ) {
        print("channelUpdated :\(state)")
        expectation.fulfill()
    }

    let expectation: XCTestExpectation

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
}
