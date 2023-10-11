//
//  QBAIRephrase.swift
//
//  Created by Injoit on 19.05.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import Foundation

/// The dependency protocol that allows for dependency injection in the module.
public var dependency: DependencyProtocol = Dependency()

/// Rephrases the given text using the specified tone.
///
/// Using `Settings.serverPath` a proxy server  like the [QuickBlox AI Assistant Proxy Server](https:github.com/QuickBlox/qb-ai-assistant-proxy-server) offers significant benefits in terms of security and functionality:
///
/// - Parameters:
///  - text: The text to be rephrased.
///  - messages: An array of `Message` objects representing the chat history.
///  - settings: The settings conforming to the `Settings` protocol, including tone, API key, user token, and server path.
///
/// - Returns: The generated rephrased text as a String.
///
public func rephrase<M, S>(text: String,
                           history messages: [M],
                           using settings: S) async throws -> String
where M: Message, S: Settings {
    let textTokens = dependency.tokenizer.parseTokensCount(from: text)
    if textTokens > settings.maxRequestTokens {
        throw QBAIException.incorrectTokensCount
    }
    
    let tokens = settings.maxRequestTokens - textTokens
    let filteredMessages = dependency.tokenizer.extract(messages: messages,
                                                        byTokenLimit: tokens)
    
    
    return try await dependency.restSource.request(rephrase: text,
                                                   with: filteredMessages,
                                                   using: settings)
}

/// Rephrases the given text using the specified tone.
///
/// Using `Settings.serverPath` a proxy server  like the [QuickBlox AI Assistant Proxy Server](https:github.com/QuickBlox/qb-ai-assistant-proxy-server) offers significant benefits in terms of security and functionality:
///
/// - Parameters:
///  - text: The text to be rephrased.
///  - settings: The settings conforming to the `Settings` protocol, including tone, API key, user token, and server path.
///
/// - Returns: The generated rephrased text as a String.
///
public func rephrase<S>(text: String, using settings: S)
async throws -> String where S: Settings {
    let empty: [AIMessage] = []
    return try await rephrase(text: text, history: empty, using: settings)
}
