//
//  RtmClientConfig.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// A configuration struct for initializing the Agora Real-Time Messaging (RTM) client.
@objc public class RtmClientConfig: NSObject {
    internal let config: AgoraRtmClientConfig

    /// Creates an instance of `RtmClientConfig` with the provided parameters.
    ///
    /// - Parameters:
    ///   - appId: The unique identifier of the application.
    ///   - userId: The user ID for the RTM client.
    ///   - useStringUserId: A flag to indicate whether the user ID should be treated as a string or an integer.
    ///                      Default is `true`.
    @objc public init(appId: String, userId: String, useStringUserId: Bool = true) {
        let config = AgoraRtmClientConfig(appId: appId, userId: userId)
        self.config = config
        config.useStringUserId = useStringUserId
    }

    /// Creates an instance of `RtmClientConfig` with the provided parameters.
    ///
    /// - Parameters:
    ///   - appId: The unique identifier of the application.
    ///   - userId: The user ID for the RTM client as an integer value.
    ///   - useStringUserId: A flag to indicate whether the user ID should be treated as a string or an integer.
    ///                      Default is `false`.
    public init(appId: String, userId: Int, useStringUserId: Bool = false) {
        self.config = AgoraRtmClientConfig(appId: appId, userId: String(userId))
        config.useStringUserId = useStringUserId
    }

    /// The area code for the RTM client.
    @objc public var areaCode: RtmAreaCode {
        get { .fromLegacy(config.areaCode) }
        set { config.areaCode = newValue.legacyAreaCode! }
    }

    /// The timeout for user presence status updates.
    @objc public var presenceTimeout: UInt32 {
        get { config.presenceTimeout }
        set { config.presenceTimeout = newValue }
    }

    /// A flag indicating whether the user ID should be treated as a string or an integer.
    @objc public var useStringUserId: Bool {
        get { config.useStringUserId }
        set { config.useStringUserId = newValue }
    }

    // Strong references to retain the Objective-C objects
    private var _encryptionConfig: AgoraRtmEncryptionConfig?

    /// The configuration for logging options.
    @objc public var logConfig: RtmLogConfig? {
        didSet { config.logConfig = logConfig?.config }
    }

    /// The configuration for proxy options.
    @objc public var proxyConfig: RtmProxyConfig? {
        didSet { config.proxyConfig = proxyConfig?.config }
    }

    /// The encryption configuration for the RTM client.
    public var encryptionConfig: RtmEncryptionConfig? {
        get {
            guard let encConf = config.encryptionConfig, encConf.encryptionMode != .none,
                    let encKey = encConf.encryptionKey else {
                return nil
            }
            switch encConf.encryptionMode {
            case .none: return nil
            case .AES128GCM: return .aes128GCM(key: encKey, salt: encConf.encryptionSalt)
            case .AES256GCM: return .aes256GCM(key: encKey, salt: encConf.encryptionSalt)
            @unknown default: return nil
            }
        }
        set {
            guard let newValue = newValue else {
                config.encryptionConfig = nil
                self._encryptionConfig = nil
                return
            }
            let encConfig = AgoraRtmEncryptionConfig()
            switch newValue {
            case .aes128GCM(let key, let salt):
                encConfig.encryptionKey = key
                encConfig.encryptionSalt = salt
                encConfig.encryptionMode = .AES128GCM
            case .aes256GCM(let key, let salt):
                encConfig.encryptionKey = key
                encConfig.encryptionSalt = salt
                encConfig.encryptionMode = .AES256GCM
            case .none: break
            }
            self._encryptionConfig = encConfig
            config.encryptionConfig = encConfig
        }
    }

    public static func encryptSaltString(salt: String?) -> Data? {
        if let salt, let data = salt.data(using: .utf8) {
            let base64Encoded = data.base64EncodedString()
            // Now use base64Encoded in your function call
            return Data(base64Encoded: base64Encoded, options: .ignoreUnknownCharacters)
        }
        return nil
    }
}
