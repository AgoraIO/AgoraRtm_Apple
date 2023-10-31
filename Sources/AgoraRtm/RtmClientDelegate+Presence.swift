//
//  RtmClientDelegate+Presence.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// Represents the type of an RTM presence event.
public enum RtmPresenceEventType {
    /// Unknown event type.
    case none
    /// The presence snapshot of this channel.
    /// - Parameter states: The snapshot of presence information.
    case snapshot(states: [String: [String: String]])
    /// The presence event triggered in interval mode.
    /// - Parameter interval: Represents an interval of presence event in the Agora RTM system.
    case interval(_ interval: RtmPresenceIntervalInfo)
    /// Triggered when a remote user joins the channel.
    ///
    /// - Parameter user: Username of the user that has joined the channel.
    case remoteJoinChannel(user: String)
    /// Triggered when a remote user leaves the channel.
    ///
    /// - Parameter user: Username of the user that has left the channel.
    case remoteLeaveChannel(user: String)
    /// Triggered when a remote user's connection times out.
    ///
    /// - Parameter user: Username of the user that has lost connection.
    case remoteConnectionTimeout(user: String)
    /// Triggered when a user's state changes.
    ///
    /// - Parameters:
    ///   - user: Username of the user whose state has changed.
    ///   - states: New collection of states.
    case remoteStateChanged(user: String, states: [String: String])
    /// Triggered when a user joins a channel without presence service.
    ///
    /// - Parameter user: Username of the user that has joined without presence.
    @available(*, deprecated, message: "Deprecated case, do not use.")
    case errorOutOfService(user: String)
}

/// Represents an interval of presence event in the Agora RTM system.
public struct RtmPresenceIntervalInfo {
    /// The list of users who joined during this interval.
    public let joinUserList: [String]
    /// The list of users who left during this interval.
    public let leaveUserList: [String]
    /// The list of users whose connection timed out during this interval.
    public let timeoutUserList: [String]
    /// The dictionary of user states changed during this interval.
    public let userStateList: [String: [String: String]]

    /// Initializes an instance of `RtmPresenceIntervalInfo`.
    /// - Parameter agoraIntervalInfo: The AgoraRtmPresenceIntervalInfo object
    ///                                to extract presence interval details from.
    internal init?(_ agoraIntervalInfo: AgoraRtmPresenceIntervalInfo?) {
        guard let agoraIntervalInfo = agoraIntervalInfo else { return nil }
        self.joinUserList = agoraIntervalInfo.joinUserList
        self.leaveUserList = agoraIntervalInfo.leaveUserList
        self.timeoutUserList = agoraIntervalInfo.timeoutUserList
        self.userStateList = agoraIntervalInfo.userStateList.reduce(
            into: [String: [String: String]]()
        ) { result, userState in
            var stateDict = [String: String]()
            userState.states.forEach { keyValue in
                stateDict[keyValue.key] = keyValue.value
            }
            result[userState.userId] = stateDict
        }
    }
}

/// Represents a user state in the Agora RTM system.
public struct RtmUserState {
    /// The user ID.
    public let userId: String
    /// The dictionary of user states.
    public let states: [String: String]

    /// Initializes an instance of `RtmUserState`.
    /// - Parameter objcUserState: The AgoraRtmUserState object to extract user state details from.
    internal init(_ objcUserState: AgoraRtmUserState) {
        userId = objcUserState.userId

        var statesDict = [String: String]()
        for stateItem in objcUserState.states {
            statesDict[stateItem.key] = stateItem.value
        }
        states = statesDict
    }
}

/// Represents a presence event in the Agora RTM system.
public struct RtmPresenceEvent {
    /// The type of the presence event.
    public let type: RtmPresenceEventType
    /// The channel type of the presence event, ``RtmChannelType/message`` or ``RtmChannelType/stream``.
    public let channelType: RtmChannelType
    /// The channel to which the presence event was triggered.
    public let channelName: String
    /// The user who triggered this event.
    public let publisher: String?
    /// The user states associated with the presence event.
    public let states: [String: String]
    /// The presence interval information. Only valid when in interval mode.
    public var interval: RtmPresenceIntervalInfo? {
        switch self.type {
        case .interval(let interval): return interval
        default: return nil
        }
    }

    private static func publisherPresenceType(
        eventType: AgoraRtmPresenceEventType, publisher: String?
    ) -> RtmPresenceEventType {
        guard let publisher else {
            print("""
            Invalid presence:
                Type: \(eventType.rawValue)
                Reason: missing publisher
            """)
            return .none
        }
        if eventType == .remoteJoinChannel {
            return .remoteJoinChannel(user: publisher)
        } else if eventType == .remoteLeaveChannel {
            return .remoteLeaveChannel(user: publisher)
        } else if eventType == .remoteConnectionTimeout {
            return .remoteConnectionTimeout(user: publisher)
//            errorOutOfService is deprecated
//        } else if eventType == .errorOutOfService {
//            return .errorOutOfService(user: publisher)
        }
        print("""
        Invalid presence:
            Type: \(eventType.rawValue)
            Reason: Wrong Type for \(#function)
        """)
        return .none

    }
    /// Initializes an instance of `RtmPresenceEvent`.
    /// - Parameter presence: The AgoraRtmPresenceEvent object to extract presence event details from.
    internal init?(_ presence: AgoraRtmPresenceEvent) {
        let states = presence.states.reduce(into: [String: String]()) { result, stateItem in
            result[stateItem.key] = stateItem.value
        }
        switch presence.type {
        case .remoteJoinChannel, .remoteLeaveChannel,
             .remoteConnectionTimeout,
             .errorOutOfService:
            self.type = RtmPresenceEvent.publisherPresenceType(
                eventType: presence.type, publisher: presence.publisher)
        case .remoteStateChanged:
            if let publisher = presence.publisher {
                self.type = .remoteStateChanged(user: publisher, states: states)
            } else {
                print("""
                Invalid presence:
                    Type: remoteStateChanged
                    Reason: missing publisher
                """)
                self.type = .none
            }
        case .snapshot:
            self.type = .snapshot(states: presence.snapshot.reduce(
                into: [String: [String: String]]()
            ) { result, userState in
                var stateDict = [String: String]()
                userState.states.forEach { keyValue in
                    stateDict[keyValue.key] = keyValue.value
                }
                result[userState.userId] = stateDict
            })
        case .interval:
            guard let interval = RtmPresenceIntervalInfo(presence.interval) else {
                print("""
                Invalid presence:
                    Type: interval
                    Reason: missing interval data
                """)
                return nil
            }
            self.type = .interval(interval)
        case .none: self.type = .none
        @unknown default: self.type = .none
        }
        self.states = states
        self.channelType = .init(rawValue: presence.channelType.rawValue) ?? .none
        self.channelName = presence.channelName
        self.publisher = presence.publisher
    }
}
