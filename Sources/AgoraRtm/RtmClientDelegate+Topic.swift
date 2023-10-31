//
//  RtmClientDelegate+Topic.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// Represents the type of an RTM topic event.
public enum RtmTopicEventType: Int {
    /// Unknown event type.
    case none = 0
    /// The topic snapshot of this channel.
    case snapshot = 1
    /// Triggered when a remote user joins a topic.
    case remoteJoinTopic = 2
    /// Triggered when a remote user leaves a topic.
    case remoteLeaveTopic = 3
}

/// Represents a topic event in the Agora RTM system.
public class RtmTopicEvent {
    /// The type of the topic event.
    public var type: RtmTopicEventType
    /// The channel in which the topic event was triggered.
    public var channelName: String
    /// The userId which triggered the topic event.
    public var publisher: String
    /// Topic information array.
    public var topicInfos: [RtmTopicInfo]

    /// Initializes an instance of `RtmTopicEvent`.
    /// - Parameter agorartmTopicEvent: The AgoraRtmTopicEvent object to extract topic event details from.
    internal init(from agorartmTopicEvent: AgoraRtmTopicEvent) {
        self.type = RtmTopicEventType(rawValue: agorartmTopicEvent.type.rawValue) ?? .none
        self.channelName = agorartmTopicEvent.channelName
        self.publisher = agorartmTopicEvent.publisher
        self.topicInfos = agorartmTopicEvent.topicInfos.map { RtmTopicInfo(from: $0) }
    }
}

/// Represents topic information in the Agora RTM system.
public class RtmTopicInfo {
    /// The name of the topic.
    public var topic: String
    /// The publisher array.
    public var publishers: [RtmPublisherInfo]

    /// Initializes an instance of `RtmTopicInfo`.
    /// - Parameter agorartmTopicInfo: The AgoraRtmTopicInfo object to extract topic information from.
    internal init(from agorartmTopicInfo: AgoraRtmTopicInfo) {
        self.topic = agorartmTopicInfo.topic
        self.publishers = agorartmTopicInfo.publishers.map { RtmPublisherInfo(from: $0) }
    }
}

/// Represents publisher information in the Agora RTM system.
public class RtmPublisherInfo: NSObject {
    /// The publisher user ID.
    public var publisherUserId: String
    /// The metadata of the publisher.
    public var publisherMeta: String?

    /// Initializes an instance of `RtmPublisherInfo`.
    /// - Parameter agorartmPublisherInfo: The AgoraRtmPublisherInfo object to extract publisher information from.
    internal init(from agorartmPublisherInfo: AgoraRtmPublisherInfo) {
        self.publisherUserId = agorartmPublisherInfo.publisherUserId
        self.publisherMeta = agorartmPublisherInfo.publisherMeta
        super.init()
    }
}
