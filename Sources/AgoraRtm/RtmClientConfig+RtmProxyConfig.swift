//
//  RtmClientConfig+RtmProxyConfig.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// A configuration for the Agora Real-Time Messaging (RTM) client's proxy settings.
@objc public class RtmProxyConfig: NSObject {
    internal let config: AgoraRtmProxyConfig

    /// The type of proxy server to use for RTM client communication.
    @objc public enum RtmProxyType: Int {
        /// HTTP proxy type.
        case http
        /// None proxy type.
        case none
    }

    /// Initializes the RTM proxy configuration with the specified proxy type, server, port, account, and password.
    ///
    /// - Parameters:
    ///   - proxyType: The type of proxy server to use. Set to `.http` to use an HTTP proxy.
    ///   - server: The proxy server address.
    ///   - port: The proxy server port.
    ///   - account: The account to authenticate with the proxy server, if required.
    ///   - password: The password to authenticate with the proxy server, if required.
    @objc public init(
        proxyType: RtmProxyType, server: String, port: UInt16, account: String? = nil, password: String? = nil
    ) {
        config = AgoraRtmProxyConfig(server: server, port: port, proxyType: proxyType == .http ? .http : .none)
        config.account = account
        config.password = password
    }

    /// The type of proxy server to use.
    @objc public var proxyType: RtmProxyType {
        get { config.proxyType == .http ? .http : .none }
        set { config.proxyType = newValue != .none ? .http : .none }
    }

    /// The proxy server address.
    @objc public var server: String {
        get { config.server }
        set { config.server = newValue }
    }

    /// The proxy server port.
    @objc public var port: UInt16 {
        get { config.port }
        set { config.port = newValue }
    }

    /// The account to authenticate with the proxy server, if required.
    @objc public var account: String? {
        get { config.account }
        set { config.account = newValue }
    }

    /// The password to authenticate with the proxy server, if required.
    @objc public var password: String? {
        get { config.password }
        set { config.password = newValue }
    }
}
