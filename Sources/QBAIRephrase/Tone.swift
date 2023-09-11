//
//  Tone.swift
//
//  Created by Injoit on 07.09.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import Foundation

public protocol Tone: Codable, Equatable, Hashable {
    var name: String { get }
    var behavior: String? { get }
    var icon: String? { get }
    var summary: String { get }
    
    init(name: String)
}

public extension Tone {
    static func == (lhs: any Tone, rhs: any Tone) -> Bool {
      return lhs.name == rhs.name
    }
}

public struct ToneInfo: Tone {
    public let name: String
    public private(set) var behavior: String?
    public private(set) var icon: String?
    
    public init(name: String) {
        self.name = name
    }
    
    public init(name: String,
                behavior: String? = nil,
                icon: String? = nil) {
        self.init(name: name)
        self.behavior = behavior
        self.icon = icon
    }
    
    public var summary: String {
        var summary = name
        if let behavior = behavior, behavior.isEmpty == false {
            summary += ". \(behavior)"
        }
        return summary
    }
}

public extension ToneInfo {
    static let professional = ToneInfo(
        name: "Professional Tone",
        behavior: "This would edit messages to sound more formal, using technical vocabulary, clear sentence structures, and maintaining a respectful tone. It would avoid colloquial language and ensure appropriate salutations and sign-offs.",
        icon: "👔"
    )
    
    static let friendly = ToneInfo(
        name: "Friendly Tone",
        behavior: "This would adjust messages to reflect a casual, friendly tone. It would incorporate casual language, use emoticons, exclamation points, and other informalities to make the message seem more friendly and approachable.",
        icon: "🤝"
    )
    
    static let encouraging = ToneInfo(
        name: "Encouraging Tone",
        behavior: "This tone would be useful for motivation and encouragement. It would include positive words, affirmations, and express support and belief in the recipient.",
        icon: "💪"
    )
    
    static let empathetic = ToneInfo(
        name: "Empathetic Tone",
        behavior: "This tone would be utilized to display understanding and empathy. It would involve softer language, acknowledging feelings, and demonstrating compassion and support.",
        icon: "🤲"
    )
    
    static let neutral = ToneInfo(
        name: "Neutral Tone",
        behavior: "For times when you want to maintain an even, unbiased, and objective tone. It would avoid extreme language and emotive words, opting for clear, straightforward communication.",
        icon: "😐"
    )
    
    static let assertive = ToneInfo(
        name: "Assertive Tone",
        behavior: "This tone is beneficial for making clear points, standing ground, or in negotiations. It uses direct language, is confident, and does not mince words.",
        icon: "🔨"
    )
    
    static let instructive = ToneInfo(
        name: "Instructive Tone",
        behavior: "This tone would be useful for tutorials, guides, or other teaching and training materials. It is clear, concise, and walks the reader through steps or processes in a logical manner.",
        icon: "📚"
    )
    
    static let persuasive = ToneInfo(
        name: "Persuasive Tone",
        behavior: "This tone can be used when trying to convince someone or argue a point. It uses persuasive language, powerful words, and logical reasoning.",
        icon: "👆"
    )
    
    static let sarcastic = ToneInfo(
        name: "Sarcastic/Ironic Tone",
        behavior: "This tone can make the communication more humorous or show an ironic stance. It is harder to implement as it requires the AI to understand nuanced language and may not always be taken as intended by the reader.",
        icon: "😏"
    )
    
    static let poetic = ToneInfo(
        name: "Poetic Tone",
        behavior: "This would add an artistic touch to messages, using figurative language, rhymes, and rhythm to create a more expressive text.",
        icon: "🎭"
    )
}
