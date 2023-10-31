//
//  RtmStorage.swift
//  
//
//  Created by Max Cobb on 07/08/2023.
//

import AgoraRtmKit

/// Represents the options for metadata in the Agora RTM system.
public class RtmMetadataOptions {
    /// Indicates whether or not to notify the server to update the modify timestamp of metadata.
    public var recordTs: Bool

    /// Indicates whether or not to notify the server to update the modify user ID of metadata.
    public var recordUserId: Bool

    internal init(agoraOptions: AgoraRtmMetadataOptions) {
        self.recordTs = agoraOptions.recordTs
        self.recordUserId = agoraOptions.recordUserId
    }

    internal var objcVersion: AgoraRtmMetadataOptions {
        let agoraOptions = AgoraRtmMetadataOptions()
        agoraOptions.recordTs = recordTs
        agoraOptions.recordUserId = recordUserId
        return agoraOptions
    }

    public init(recordTs: Bool = true, recordUserId: Bool = true) {
        self.recordTs = true
        self.recordUserId = true
    }
}

/// Represents storage operations for metadata in the Agora RTM system.
public class RtmStorage {

    internal var storage: AgoraRtmStorage

    /// Initializes a new instance of the RtmStorage class.
    ///
    /// - Parameter storage: The underlying AgoraRtmStorage instance used for metadata operations.
    internal init?(storage: AgoraRtmStorage?) {
        guard let storage else { return nil }
        self.storage = storage
    }

    /// Creates the metadata object and returns the pointer. This is the only valid way to create AgoraRtmMetadata.
    public func createMetadata() -> RtmMetadata? {
        guard let agoraMetadata = storage.createMetadata() else {
            return nil
        }
        return RtmMetadata(agoraMetadata)
    }
}
