//
//  QBAIRephrase.swift
//
//  Created by Injoit on 19.05.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import Foundation

/// Provides access to the available tones.
public var tones: [any Tone] {
    return Cache.tones
}

/// Resets the tones to their default predefined values.
public func resetTonesToDefault() {
    Cache.reset()
}

/// Removes a specific tone from the list of available tones.
///
/// - Parameter tone: The tone to be removed.
public func remove<T: Tone>(_ tone: T) {
    guard let tones = tones as? [T] else {
        return
    }
    
    guard let index = tones.firstIndex(of: tone) else {
        return
    }
    
    removeTone(at: index)
}

/// Removes a specific tone (`ToneInfo`) from the list of available tones.
///
/// - Parameter tone: The tone to be removed.
public func remove(tone: ToneInfo) {
    remove(tone)
}

/// Removes a tone at the specified index from the list of available tones.
///
/// - Parameter index: The index of the tone to be removed.
public func removeTone(at index: Int) {
    var newTones = tones
    newTones.remove(at: index)
    Cache.save(newTones.compactMap{ $0 as? ToneInfo })
}

/// Retrieves the index of a specific tone in the list of available tones.
///
/// - Parameter tone: The tone to find.
/// - Returns: The index of the tone, or nil if not found.
public func index<T: Tone>(of tone: T) -> Int? {
    guard let tones = tones as? [T] else {
        return nil
    }
    return tones.firstIndex(of: tone)
}

/// Retrieves the index of a specific tone (`ToneInfo`) in the list of available tones.
///
/// - Parameter tone: The tone to find.
/// - Returns: The index of the tone, or nil if not found.
public func toneIndex(_ tone: ToneInfo) -> Int? {
    return index(of: tone)
}

/// Inserts a specific tone at the specified index in the list of available tones.
///
/// - Parameters:
///   - tone: The tone to insert.
///   - index: The index at which to insert the tone.
public func insert<T: Tone>(_ tone: T, at index: Int) {
    guard var newTones = tones as? [T] else {
        return
    }
    
    var insertIndex = index
    
    if newTones.contains(tone),
        let oldIndex = newTones.firstIndex(of: tone) {
        remove(tone)
        newTones.remove(at: oldIndex)
        if index >= oldIndex, index != 0 {
            insertIndex = index - 1
        }
    }
    
    if newTones.indices.contains(insertIndex) == false {
        append(tone)
        return
    }
    
    newTones.insert(tone, at: insertIndex)
    
    Cache.save(newTones.compactMap{ $0 as? ToneInfo })
}

/// Inserts a specific tone (`ToneInfo`) at the specified index in the list of available tones.
///
/// - Parameters:
///   - tone: The tone to insert.
///   - index: The index at which to insert the tone.
public func insert(tone: ToneInfo, at index: Int) {
    insert(tone, at: index)
}

/// Appends a specific tone to the list of available tones.
///
/// - Parameter tone: The tone to append.
func append<T: Tone>(_ tone: T) {
    guard var newTones = tones as? [T] else {
        return
    }
    
    if newTones.contains(tone),
        let oldIndex = newTones.firstIndex(of: tone) {
        remove(tone)
        newTones.remove(at: oldIndex)
    }
    
    newTones.append(tone)
    
    Cache.save(newTones.compactMap{ $0 as? ToneInfo })
}

/// Appends a specific tone (`ToneInfo`) to the list of available tones.
///
/// - Parameter tone: The tone to append.
func append(tone: ToneInfo) {
    append(tone)
}

/// Represents the content type to be considered when rephrasing text.
public enum ToneContent {
    case name
    case summary
}

/// Represents the settings used for QBAIRephrase.
public var settings = QBAIRephrase.Settings()

public class Settings {
    /// The maximum token count allowed for message processing.
    public var maxTokenCount: Int = 3500
    
    /// The content type to be considered when rephrasing text.
    public var toneContent: ToneContent = .summary
    
    /// Settings for OpenAI model usage.
    public var openAI: OpenAISettings = OpenAISettings()
}

/// Represents the various exceptions that can be thrown by `QBAIRephrase`.
public enum QBAIException: Error {
    /// Thrown when the provided token has an incorrect value.
    case incorrectToken
    
    /// Thrown when the provided text tokens count has an incorrect value.
    case incorrectTokensCount
    
    /// Thrown when the server URL has an incorrect value.
    case incorrectProxyServerUrl
}

/// The dependency protocol that allows for dependency injection in the module.
public var dependency: DependencyProtocol = Dependency()

/// Rephrases the given text using the specified tone and API key from OpenAI.
///
/// This method rephrases the provided text using the OpenAI API with the given API key and the selected tone. It sends a request to OpenAI for rephrasing and returns the generated rephrased text as a String.
///
/// - Parameters:
///   - text: The text to be rephrased.
///   - tone: The tone to be applied to the rephrased text.
///   - apiKey: The API key to be used for making the request to OpenAI.
///
/// - Throws: A `QBAIException` if an error occurs during the request or validation.
///
/// - Returns: The generated rephrased text as a String.
public func openAI<T: Tone>(rephrase text: String,
                            using tone: T,
                            secret apiKey: String) async throws -> String {
    if apiKey.isNotCorrect {
        throw QBAIException.incorrectToken
    }
    
    let tokenizer = Tokenizer()
    
    var count: Int
    switch settings.toneContent {
    case .name:
        count = tokenizer.parseTokensCount(from: text + " " + tone.name)
    case .summary:
        count = tokenizer.parseTokensCount(from: text + " " + tone.summary)
    }
    
    if count > settings.maxTokenCount {
        throw QBAIException.incorrectTokensCount
    }
    
    return try await dependency.restSource.requestOpenAI(rephrase: text,
                                                         tone: tone,
                                                         key: apiKey,
                                                         apply: settings.openAI)
}

/// Rephrases the given text using the specified tone (ToneInfo) and API key from OpenAI.
///
/// This method rephrases the provided text using the OpenAI API with the given API key and the selected tone (ToneInfo). It sends a request to OpenAI for rephrasing and returns the generated rephrased text as a String.
///
/// - Parameters:
///   - text: The text to be rephrased.
///   - tone: The tone (ToneInfo) to be applied to the rephrased text.
///   - apiKey: The API key to be used for making the request to OpenAI.
///
/// - Throws: A `QBAIException` if an error occurs during the request or validation.
///
/// - Returns: The generated rephrased text as a String.
public func openAI(rephrase text: String,
                   tone: ToneInfo,
                   secret apiKey: String) async throws -> String {
    return try await openAI(rephrase: text, using: tone, secret: apiKey)
}

/// Rephrases the given text using the specified tone, QuickBlox token, and proxy URL.
///
/// This method rephrases the provided text using the OpenAI API with the selected tone, QuickBlox user token, and proxy URL. It sends a secure request through the proxy server for rephrasing and returns the generated rephrased text as a String.
/// Using a proxy server like the [QuickBlox AI Assistant Proxy Server](https:github.com/QuickBlox/qb-ai-assistant-proxy-server) offers significant benefits in terms of security and functionality:
///
/// Enhanced Security:
/// - When making direct requests to the OpenAI API from the client-side, sensitive information like API keys may be exposed. By using a proxy server, the API keys are securely stored on the server-side, reducing the risk of unauthorized access or potential breaches.
/// - The proxy server can implement access control mechanisms, ensuring that only authenticated and authorized users with valid QuickBlox user tokens can access the OpenAI API. This adds an extra layer of security to the communication.
///
/// Protection of API Keys:
///  - Exposing API keys on the client-side could lead to misuse, abuse, or accidental exposure. A proxy server hides these keys from the client, mitigating the risk of API key exposure.
///  - Even if an attacker gains access to the client-side code, they cannot directly obtain the API keys, as they are kept confidential on the server.
///
///  Rate Limiting and Throttling:
///  - The proxy server can enforce rate limiting and throttling to control the number of requests made to the OpenAI API. This helps in complying with API usage policies and prevents excessive usage that might lead to temporary or permanent suspension of API access.
///
///  Request Logging and Monitoring:
///  - By using a proxy server, requests to the OpenAI API can be logged and monitored for auditing and debugging purposes. This provides insights into API usage patterns and helps detect any suspicious activities.
///
///  Flexibility and Customization:
///  - The proxy server acts as an intermediary, allowing developers to introduce custom functionalities, such as response caching, request modification, or adding custom headers. These customizations can be implemented without affecting the client-side code.
///
///  SSL/TLS Encryption:
///  - The proxy server can enforce SSL/TLS encryption for data transmission between the client and the server. This ensures that data remains encrypted and secure during communication.
///
/// - Parameters:
///   - text: The text to be rephrased.
///   - tone: The tone to be applied to the rephrased text.
///   - qbToken: The QuickBlox user token used for proxy communication.
///   - urlPath: The proxy URL to be used for making the request to OpenAI.
///
/// - Throws: A `QBAIException` if an error occurs during the request or validation.
///
/// - Returns: The generated rephrased text as a String.
public func openAI<T: Tone>(rephrase text: String,
                            using tone: T,
                            qbToken: String,
                            proxy urlPath: String) async throws -> String {
    if qbToken.isNotCorrect {
        throw QBAIException.incorrectToken
    }
    
    if ServerUrlValidator.isNotCorrect(urlPath) {
        throw QBAIException.incorrectProxyServerUrl
    }
    
    let tokenizer = Tokenizer()
    
    var count: Int
    switch settings.toneContent {
    case .name:
        count = tokenizer.parseTokensCount(from: text + " " + tone.name)
    case .summary:
        count = tokenizer.parseTokensCount(from: text + " " + tone.summary)
    }
    
    if count > settings.maxTokenCount {
        throw QBAIException.incorrectTokensCount
    }
    
    return try await dependency.restSource.requestOpenAI(rephrase: text,
                                                         tone: tone,
                                                         token: qbToken,
                                                         proxy: urlPath,
                                                         apply: settings.openAI)
}

/// Rephrases the given text using the specified tone (ToneInfo), QuickBlox token, and proxy URL.
///
/// This method rephrases the provided text using the OpenAI API with the selected tone (ToneInfo), QuickBlox user token, and proxy URL. It sends a secure request through the proxy server for rephrasing and returns the generated rephrased text as a String.
/// Using a proxy server like the [QuickBlox AI Assistant Proxy Server](https:github.com/QuickBlox/qb-ai-assistant-proxy-server) offers significant benefits in terms of security and functionality:
///
/// Enhanced Security:
/// - When making direct requests to the OpenAI API from the client-side, sensitive information like API keys may be exposed. By using a proxy server, the API keys are securely stored on the server-side, reducing the risk of unauthorized access or potential breaches.
/// - The proxy server can implement access control mechanisms, ensuring that only authenticated and authorized users with valid QuickBlox user tokens can access the OpenAI API. This adds an extra layer of security to the communication.
///
/// Protection of API Keys:
///  - Exposing API keys on the client-side could lead to misuse, abuse, or accidental exposure. A proxy server hides these keys from the client, mitigating the risk of API key exposure.
///  - Even if an attacker gains access to the client-side code, they cannot directly obtain the API keys, as they are kept confidential on the server.
///
///  Rate Limiting and Throttling:
///  - The proxy server can enforce rate limiting and throttling to control the number of requests made to the OpenAI API. This helps in complying with API usage policies and prevents excessive usage that might lead to temporary or permanent suspension of API access.
///
///  Request Logging and Monitoring:
///  - By using a proxy server, requests to the OpenAI API can be logged and monitored for auditing and debugging purposes. This provides insights into API usage patterns and helps detect any suspicious activities.
///
///  Flexibility and Customization:
///  - The proxy server acts as an intermediary, allowing developers to introduce custom functionalities, such as response caching, request modification, or adding custom headers. These customizations can be implemented without affecting the client-side code.
///
///  SSL/TLS Encryption:
///  - The proxy server can enforce SSL/TLS encryption for data transmission between the client and the server. This ensures that data remains encrypted and secure during communication.
///
/// - Parameters:
///   - text: The text to be rephrased.
///   - tone: The tone (ToneInfo) to be applied to the rephrased text.
///   - qbToken: The QuickBlox user token used for proxy communication.
///   - urlPath: The proxy URL to be used for making the request to OpenAI.
///
/// - Throws: A `QBAIException` if an error occurs during the request or validation.
///
/// - Returns: The generated rephrased text as a String.
public func openAI(rephrase text: String,
                   tone: ToneInfo,
                   qbToken: String,
                   proxy urlPath: String) async throws -> String {
    return try await openAI(rephrase: text,
                            using: tone,
                            qbToken: qbToken,
                            proxy: urlPath)
}

/// Extension to provide a utility method to check if a string is not correct by removing whitespaces and newlines from both ends and checking if the resulting string is empty.
extension String {
    var isNotCorrect: Bool {
        // Remove whitespaces and newlines from both ends of the string
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        // Check if the resulting string is empty
        return trimmedString.isEmpty
    }
}
