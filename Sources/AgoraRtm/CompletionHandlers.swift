//
//  CompletionHandlers.swift
//  
//
//  Created by Max Cobb on 12/09/2023.
//

import Foundation
import AgoraRtmKit

// Functions to handle the response cases for the objc library
internal struct CompletionHandlers {
    static func handleSyncResult<T: RtmResponseProtocol>(
        _ block: (resp: T.ResponseType?, err: AgoraRtmErrorInfo?),
        completion: ((Result<T, RtmErrorInfo>) -> Void)?, operation: String
    ) {
        guard let completion else { return }
        if let blockErr = block.err, let err = RtmErrorInfo(from: blockErr) { return completion(.failure(err)) }
        guard let resp = block.resp else {
            return completion(.failure(.noKnownError(operation: operation)))
        }
        completion(.success(T(resp)))
    }

    static func handleAsyncThrow<T: RtmResponseProtocol>(
        _ block: (resp: T.ResponseType?, err: AgoraRtmErrorInfo?), operation: String
    ) throws -> T {
        if let blockErr = block.err, let err = RtmErrorInfo(from: blockErr) {
            throw err
        }
        guard let resp = block.resp else {
            throw RtmErrorInfo.noKnownError(operation: #function)
        }
        return .init(resp)
    }
}
