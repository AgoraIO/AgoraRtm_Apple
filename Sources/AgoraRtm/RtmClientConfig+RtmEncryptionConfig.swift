//
//  RtmClientConfig+RtmEncryptionConfig.swift
//
//
//  Created by Max Cobb on 30/10/2023.
//

import Foundation

/// The encryption configuration for the RTM client.
public enum RtmEncryptionConfig: Equatable {
    /// No encryption.
    case none
    /// AES-128-GCM encryption.
    case aes128GCM(key: String, salt: Data?)
    /// AES-256-GCM encryption.
    case aes256GCM(key: String, salt: Data?)
}
