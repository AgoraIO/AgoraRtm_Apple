//
//  RtmClientDelegate+StateChanged.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import Foundation

/// Connection states between RTM SDK and Agora server.
public enum RtmClientConnectionState: Int {
    case unknown = -1
    /// The SDK is disconnected with the server.
    case disconnected = 1

    /// The SDK is connecting to the server.
    case connecting = 2

    /// The SDK is connected to the server and has joined a channel.
    /// You can now publish or subscribe to a track in the channel.
    case connected = 3

    /// The SDK keeps rejoining the channel after being disconnected from the channel,
    /// likely due to network issues.
    case reconnecting = 4

    /// The SDK fails to connect to the server or join the channel.
    case failed = 5
}

/// Reasons for connection state change.
public enum RtmClientConnectionChangeReason: Int {
    case unknown = -1
    /// The SDK is connecting to the server.
    case connecting = 0

    /// The SDK has joined the channel successfully.
    case joinSuccess = 1

    /// The connection between the SDK and the server is interrupted.
    case interrupted = 2

    /// The connection between the SDK and the server is banned by the server.
    case bannedByServer = 3

    /// The SDK fails to join the channel for more than 20 minutes and stops reconnecting to the channel.
    case joinFailed = 4

    /// The SDK has left the channel.
    case leaveChannel = 5

    /// The connection fails because the App ID is not valid.
    case invalidAppId = 6

    /// The connection fails because the channel name is not valid.
    case invalidChannelName = 7

    /// The connection fails because the token is not valid.
    case invalidToken = 8

    /// The connection fails because the token has expired.
    case tokenExpired = 9

    /// The connection is rejected by the server.
    case rejectedByServer = 10

    /// The connection changes to reconnecting because the SDK has set a proxy server.
    case settingProxyServer = 11

    /// When the connection state changes because the app has renewed the token.
    case renewToken = 12

    /// The IP Address of the app has changed.
    /// A change in the network type or IP/Port changes the IP address of the app.
    case clientIpAddressChanged = 13

    /// A timeout occurs for the keep-alive of the connection between the SDK and the server.
    case keepAliveTimeout = 14

    /// The SDK has rejoined the channel successfully.
    case rejoinSuccess = 15

    /// The connection between the SDK and the server is lost.
    case changedLost = 16

    /// The change of connection state is caused by echo test.
    case echoTest = 17

    /// The local IP Address is changed by the user.
    case clientIpAddressChangedByUser = 18

    /// The connection is failed due to join the same channel on another device with the same uid.
    case sameUidLogin = 19

    /// The connection is failed due to too many broadcasters in the channel.
    case tooManyBroadcasters = 20

    /// The connection is failed due to license validation failure.
    case licenseValidationFailure = 21

    /// The connection is failed due to user vid not support stream channel.
    case streamChannelNotAvailable = 22

    /// The connection of RTM edge service has been successfully established.
    case loginSuccess = 10001

    /// User logout Agora RTM system.
    case logout = 10002

    /// User log out Agora RTM system.
    case presenceNotReady = 10003
}

public extension RtmClientConnectionState {
    var description: String {
        switch self {
        case .disconnected: return "disconnected"
        case .connecting: return "connecting"
        case .connected: return "connected"
        case .reconnecting: return "reconnecting"
        case .failed: return "failed"
        case .unknown: return "unknown"
        }
    }
}

public extension RtmClientConnectionChangeReason {
    var description: String {
        switch self {
        case .unknown: return "unknown"
        case .connecting: return "connecting"
        case .joinSuccess: return "joinSuccess"
        case .interrupted: return "interrupted"
        case .bannedByServer: return "bannedByServer"
        case .joinFailed: return "joinFailed"
        case .leaveChannel: return "leaveChannel"
        case .invalidAppId: return "invalidAppId"
        case .invalidChannelName: return "invalidChannelName"
        case .invalidToken: return "invalidToken"
        case .tokenExpired: return "tokenExpired"
        case .rejectedByServer: return "rejectedByServer"
        case .settingProxyServer: return "settingProxyServer"
        case .renewToken: return "renewToken"
        case .clientIpAddressChanged: return "clientIpAddressChanged"
        case .keepAliveTimeout: return "keepAliveTimeout"
        case .rejoinSuccess: return "rejoinSuccess"
        case .changedLost: return "changedLost"
        case .echoTest: return "echoTest"
        case .clientIpAddressChangedByUser: return "clientIpAddressChangedByUser"
        case .sameUidLogin: return "sameUidLogin"
        case .tooManyBroadcasters: return "tooManyBroadcasters"
        case .licenseValidationFailure: return "licenseValidationFailure"
        case .streamChannelNotAvailable: return "streamChannelNotAvailable"
        case .loginSuccess: return "loginSuccess"
        case .logout: return "logout"
        case .presenceNotReady: return "presenceNotReady"
        }
    }
}
