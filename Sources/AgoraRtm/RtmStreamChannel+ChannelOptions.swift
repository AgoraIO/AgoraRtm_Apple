//
//  RtmStreamChannel+ChannelOptions.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// Options for publishing a message in the Agora Real-Time Messaging (RTM) system.
public class RtmPublishOptions {
    /// The custom type of the message, up to 32 bytes for customization.
    public let customType: String

    /// The time to calibrate data with media, only valid when a user joins the topic
    /// with ``RtmJoinTopicOption/syncWithMedia`` in a stream channel.
    public var sendTs: UInt64 = 0

    /// Initializes an instance of `AgoraRtmPublishOptions`.
    ///
    /// - Parameters:
    ///   - customType: The custom type of the message, up to 32 bytes for customization.
    ///   - sendTs: The time to calibrate data with media, only valid when a user joins the topic
    ///   with ``RtmJoinTopicOption/syncWithMedia`` in a stream channel.
    public init(customType: String, sendTs: UInt64 = 0) {
        self.customType = customType
        self.sendTs = sendTs
    }

    /// Converts the `AgoraRtmPublishOptions` to the corresponding `RtmPublishOptions` object.
    ///
    /// - Returns: The `RtmPublishOptions` object with the options set based on the `AgoraRtmPublishOptions`.
    internal var objcVersion: AgoraRtmPublishOptions {
        let objcOpt = AgoraRtmPublishOptions()
        objcOpt.customType = customType
        objcOpt.sendTs = sendTs
        return objcOpt
    }
}

/// Option set for features to use when joining the channel.
public struct RtmJoinChannelFeatures: OptionSet {
    public let rawValue: Int

    /// Whether to join channel with storage (metadata).
    public static let metadata = RtmJoinChannelFeatures(rawValue: AgoraRtmJoinChannelFeature.metadata.rawValue)
    /// Whether to join channel with user presence.
    public static let presence = RtmJoinChannelFeatures(rawValue: AgoraRtmJoinChannelFeature.presence.rawValue)
    /// Whether to join channel with lock.
    public static let lock = RtmJoinChannelFeatures(rawValue: AgoraRtmJoinChannelFeature.lock.rawValue)

    private init(rawValue: UInt) { self.init(rawValue: Int(rawValue)) }

    /// Initializes an option set with the given raw value.
    ///
    /// - Parameter rawValue: The raw value representing the option set.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

}

/// Join channel options.
public class RtmJoinChannelOption {
    /// Token used to join the channel.
    public var token: String?
    /// Option set for features to use when joining the channel.
    public var features: RtmJoinChannelFeatures

    /// Initializes an instance of `RtmJoinChannelOption`.
    ///
    /// - Parameters:
    ///   - token: Token used to join the channel.
    ///   - features: Option set for features to use when joining the channel.
    public init(token: String?, features: RtmJoinChannelFeatures = [.presence]) {
        self.token = token
        self.features = features
    }

    /// Fetches the Objective-C version of the `AgoraRtmJoinChannelOption`.
    internal var objcVersion: AgoraRtmJoinChannelOption {
        let objcOpt = AgoraRtmJoinChannelOption()
        objcOpt.token = self.token
        objcOpt.features = .init(rawValue: UInt(self.features.rawValue))
        return objcOpt
    }
}
/// The quality of service for an RTM message.
@objc public enum RtmMessageQos: Int {
    /// Messages may not arrive in order.
    case unordered = 0
    /// Messages will arrive in order.
    case ordered = 1
}

/// The priority of an RTM message.
@objc public enum RtmMessagePriority: Int {
    /// The highest priority.
    case highest = 0
    /// The high priority.
    case high = 1
    /// The normal priority (Default).
    case normal = 4
    /// The low priority.
    case low = 8
}

/// Create topic options.
public class RtmJoinTopicOption {
    /// Quality of service for the RTM message.
    public var qos: RtmMessageQos = .ordered
    /// Metadata of the topic.
    public var meta: String?
    /// Priority of the RTM message.
    public var priority: RtmMessagePriority = .normal
    /// Whether the RTM data will synchronize with media.
    public var syncWithMedia: Bool = false

    /// Fetches the Objective-C version of the `AgoraRtmJoinTopicOption`.
    internal var objcVersion: AgoraRtmJoinTopicOption {
        let objcOpt = AgoraRtmJoinTopicOption()
        objcOpt.qos = .init(rawValue: qos.rawValue)!
        objcOpt.meta = self.meta
        objcOpt.priority = .init(rawValue: self.priority.rawValue)!
        objcOpt.syncWithMedia = self.syncWithMedia
        return objcOpt
    }

    /// Create a new ``RtmJoinTopicOption`` instance.
    ///
    /// Used with ``RtmStreamChannel/joinTopic(_:with:)``.
    ///
    /// - Parameters:
    ///   - qos: Quality of service for the RTM message.
    ///   - meta: Metadata of the topic.
    ///   - priority: Priority of the RTM message.
    ///   - syncWithMedia: Whether the RTM data will synchronize with media.
    public init(
        qos: RtmMessageQos = .ordered, meta: String? = nil,
        priority: RtmMessagePriority = .normal, syncWithMedia: Bool = false
    ) {
        self.qos = qos
        self.meta = meta
        self.priority = priority
        self.syncWithMedia = syncWithMedia
    }
}
