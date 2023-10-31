//
//  RtmClientConfigTests.swift
//  
//
//  Created by Max Cobb on 13/08/2023.
//

import XCTest
@testable import AgoraRtm
@testable import AgoraRtmKit

final class RtmClientConfigTests: XCTestCase {

    var config: RtmClientConfig!
    var configInt: RtmClientConfig!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        config = RtmClientConfig(appId: "sampleAppId", userId: "sampleUserId")
        configInt = RtmClientConfig(appId: "sampleAppId", userId: 12345)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitWithStringAndIntUserId() {
        XCTAssertEqual(config.config.appId, "sampleAppId")
        XCTAssertEqual(config.config.userId, "sampleUserId")
        XCTAssertTrue(config.config.useStringUserId)
        XCTAssertEqual(configInt.config.appId, "sampleAppId")
        XCTAssertEqual(configInt.config.userId, "12345")
        XCTAssertFalse(configInt.config.useStringUserId)
    }

    func testPresenceTimeoutProperty() {
        config.presenceTimeout = 100
        XCTAssertEqual(config.config.presenceTimeout, 100)
    }

    func testUseStringUserIdProperty() {
        config.useStringUserId = false
        XCTAssertFalse(config.config.useStringUserId)
    }

    func testEncryptionConfigAES128GCM() {
        XCTAssertEqual(config.config.encryptionConfig?.encryptionKey, nil)
        config.encryptionConfig = .aes128GCM(
            key: "sampleKey", salt: RtmClientConfig.encryptSaltString(salt: "sampleSalt")
        )
        XCTAssertEqual(config.config.encryptionConfig?.encryptionKey, "sampleKey")
        XCTAssertEqual(String(
            data: config.config.encryptionConfig?.encryptionSalt ?? Data(), encoding: .utf8
        ), "sampleSalt")
        XCTAssertEqual(config.config.encryptionConfig?.encryptionMode, .AES128GCM)
        XCTAssertEqual(
            config.encryptionConfig,
            .aes128GCM(key: "sampleKey", salt: RtmClientConfig.encryptSaltString(salt: "sampleSalt"))
        )
    }

    func testEncryptionConfigAES256GCM() {
        config.encryptionConfig = .aes256GCM(
            key: "sampleKey",
            salt: RtmClientConfig.encryptSaltString(salt: "sampleSalt")
        )
        XCTAssertEqual(config.config.encryptionConfig?.encryptionKey, "sampleKey")
        XCTAssertEqual(String(
            data: config.config.encryptionConfig?.encryptionSalt ?? Data(), encoding: .utf8
        ), "sampleSalt")
        XCTAssertEqual(config.config.encryptionConfig?.encryptionMode, .AES256GCM)
        config.encryptionConfig = nil
        XCTAssertEqual(config.encryptionConfig, nil)
        XCTAssertEqual(config.config.encryptionConfig, nil)
    }

    func testLogConfig() {
        config.logConfig = RtmLogConfig(level: .error, fileSizeInKB: 1024)
        XCTAssertEqual(config.logConfig?.level, .error)
        XCTAssertEqual(config.config.logConfig?.fileSizeInKB, config.logConfig?.fileSizeInKB)
        XCTAssertEqual(config.logConfig?.fileSizeInKB, 1024)
    }

    func testProxyConfig() {
        let proxyConfig = RtmProxyConfig(proxyType: .http, server: "proxyServer", port: 8080)
        config.proxyConfig = proxyConfig
        XCTAssertEqual(config.proxyConfig?.proxyType, .http)
        XCTAssertEqual(config.config.proxyConfig?.proxyType, .http)
        XCTAssertEqual(config.proxyConfig?.port, config.config.proxyConfig?.port)
        XCTAssertEqual(config.proxyConfig?.server, config.config.proxyConfig?.server)
        XCTAssertEqual(config.proxyConfig?.server, "proxyServer")
        XCTAssertEqual(config.proxyConfig?.port, 8080)
        config.proxyConfig = nil
        XCTAssertEqual(config.proxyConfig, nil)
        XCTAssertEqual(config.config.proxyConfig, nil)
    }

    func testAreaCodeConfig() {
        let euJapan: RtmAreaCode = [.europe, .japan]
        config.areaCode = euJapan
        XCTAssertEqual(config.config.areaCode, [.EU, .JP])
        config.areaCode = euJapan.union(.india)
        XCTAssertEqual(config.config.areaCode.rawValue, euJapan.union(.india).rawValue)
        let ocUnion = [AgoraRtmAreaCode.EU, .JP, .IN].reduce(0) { $0 | $1.rawValue }
        XCTAssertEqual(config.config.areaCode.rawValue, ocUnion)
    }

    func testAreaCodeValues() {
        let allSwiftAC: [RtmAreaCode] = [
            .asiaExcludingChina, .europe, .global,
            .india, .japan, .mainlandChina, .northAmerica
        ]
        let allObjcAC: [AgoraRtmAreaCode] = [.AS, .EU, .GLOB, .IN, .JP, .CN, .NA]
        for (swiftAC, objcAc) in zip(allSwiftAC, allObjcAC) {
            XCTAssertEqual(swiftAC.rawValue, objcAc.rawValue)
        }
    }

}
