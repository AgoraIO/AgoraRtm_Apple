//
//  Utilities+Encodable.swift
//  
//
//  Created by Max Cobb on 14/08/2023.
//

import Foundation

internal extension Encodable {
    /// Converts a Codable object to an NSObject.
    ///
    /// - Parameter codableValue: The Codable object to convert.
    /// - Returns: The converted NSObject or `nil` if the conversion fails.
    func convertToNSObject() -> NSObject? {
        let data = try? JSONEncoder().encode(self)
        if let data = data {
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSObject
        }
        return nil
    }

    func convertToString() throws -> String {
        // First check if Codable is a String
        if let str = self as? String { return str }

        let msg = try JSONEncoder().encode(self)

        guard let jsonString = String(data: msg, encoding: .utf8) else {
            throw RtmErrorInfo(
                errorCode: .channelInvalidMessage, operation: #function,
                reason: "message could not convert to JSON String"
            )
        }
        return jsonString
    }

}
