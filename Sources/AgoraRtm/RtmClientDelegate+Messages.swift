//
//  RtmClientDelegate+Messages.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// The type of an RTM channel.
public enum RtmChannelType: Int {
    /// Unknown channel type.
    case none = 0
    /// Message channel type.
    case message = 1
    /// Stream channel type.
    case stream = 2
}

/// The type of an RTM message.
public enum RtmMessageType: Int {
    /// The binary message type.
    case binary = 0
    /// The ASCII message type.
    case string = 1
    /// Unknown message type.
    case unknown = -1
}

public enum RtmMessageContent {
    case string(String)
    case data(Data)
}

/// A representation of an RTM message.
public struct RtmMessage {

    public let content: RtmMessageContent

    /// Initializes an instance of `RtmMessage`.
    ///
    /// - Parameters:
    ///   - data: The payload data of the message.
    ///   - type: The type of the message.
    internal init(content: RtmMessageContent) {
        self.content = content
    }

    /// Decodes a JSON string into a Codable value of the specified type.
    ///
    /// Use this function to attempt to decode a JSON string into a Codable value of the specified type.
    /// If the decoding is successful, the decoded value is returned; otherwise, nil is returned.
    ///
    /// - Parameters:
    ///   - type: The Codable type to decode the JSON string into.
    /// - Returns: A decoded Codable value of the specified type, or nil if decoding fails.
    public func decodeMessage<T: Codable>(as type: T.Type) -> T? {
        var jsonData: Data
        // Retrieve the JSON string to decode. Then convert the JSON string to UTF-8 encoded data.
        switch self.content {
        case .data(let data): jsonData = data
        case .string(let str):
            guard let strData = str.data(using: .utf8) else {
                return nil
            }
            jsonData = strData
        }

        do {
            // Initialize a JSON decoder.
            let decoder = JSONDecoder()

            /// Attempt to decode the JSON data into the specified Codable type.
            let decodedValue = try decoder.decode(type, from: jsonData)
            return decodedValue
        } catch {
            print("decode error: \(error.localizedDescription)")
            /// Decoding failed, return nil.
            return nil
        }
    }

    /// Initializes an instance of `RtmMessage` with the provided AgoraRtmMessage object.
    ///
    /// - Parameter agoraMessage: The AgoraRtmMessage object to extract message details from.
    internal init?(_ agoraMessage: AgoraRtmMessage) {
        if let data = agoraMessage.rawData {
            self.init(content: .data(data))
        } else if let str = agoraMessage.stringData {
            self.init(content: .string(str))
        } else {
            return nil
        }
    }
}

/// A representation of a message event in the Agora RTM system.
public struct RtmMessageEvent {
    /// The type of channel for the message event.
    public let channelType: RtmChannelType

    /// The name of the channel where the message event was triggered.
    public let channelName: String

    /// If the channelType is `stream`, the topic from which the message originates.
    /// Only valid for the `stream` channel type.
    public let channelTopic: String?

    /// The payload of the message event.
    public let message: RtmMessage

    /// The publisher of the message event.
    public let publisher: String

    /// The custom type of the message event.
    public let customType: String?

    /// Initializes an instance of `RtmMessageEvent` with the provided AgoraRtmMessageEvent object.
    ///
    /// - Parameter messageEvent: The AgoraRtmMessageEvent object to extract message event details from.
    internal init?(_ messageEvent: AgoraRtmMessageEvent) {
        guard let msg = RtmMessage.init(messageEvent.message) else { return nil }
        self.channelType = .init(rawValue: messageEvent.channelType.rawValue) ?? .none
        self.channelName = messageEvent.channelName
        self.channelTopic = messageEvent.channelTopic
        self.message = msg
        self.publisher = messageEvent.publisher
        self.customType = messageEvent.customType
    }
}
