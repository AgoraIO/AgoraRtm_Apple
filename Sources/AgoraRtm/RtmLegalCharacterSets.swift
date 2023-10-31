//
//  RtmLegalCharacterSets.swift
//  
//
//  Created by Max Cobb on 15/08/2023.
//

import Foundation

/// A collection of predefined character sets for input parameters in an RTM application.
public struct RtmLegalCharacterSets {
    /// The set of uppercase letters.
    internal static let uppercaseLetters = CharacterSet(charactersIn: "A"..."Z")
    /// The set of lowercase letters.
    internal static let lowercaseLetters = CharacterSet(charactersIn: "a"..."z")
    /// The set of numerical digits.
    internal static let numbers = CharacterSet(charactersIn: "0"..."9")

    /// The set of characters allowed for channel names.
    ///
    /// The `channelName` character set is a combination of:
    /// - Uppercase letters (A-Z)
    /// - Lowercase letters (a-z)
    /// - Numerical digits (0-9)
    /// - Common special characters: !#$%&()+-:;<=>.?@[]^_{|}~, (space)
    public static let channelName: CharacterSet = {
        let channelNameSpecials = CharacterSet(charactersIn: " !#$%&()+-:;<=>.?@[]^_{|}~, ")
        return [uppercaseLetters, lowercaseLetters, numbers]
            .reduce(channelNameSpecials) { $0.union($1) }
    }()

    /// The set of characters allowed for usernames.
    ///
    /// The `username` character set is the same as the ``channelName`` character set.
    public static let username = RtmLegalCharacterSets.channelName
}
