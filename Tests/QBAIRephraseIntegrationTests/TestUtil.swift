//
//  TestUtil.swift
//  QBAIRephrase
//
//  Created by Injoit on 09.09.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import Foundation
@testable import QBAIRephrase

struct Test {
    static let messages: [AIMessage] = [
        AIMessage(role: .me, text: "Hello! How can I assist you today?"),
        AIMessage(role: .other, text: "Hi, I'm looking for a new laptop. Can you recommend one?"),
        AIMessage(role: .me, text: "Of course! What are your requirements and budget for the laptop?"),
        AIMessage(role: .other, text: "I need a laptop for gaming and programming. My budget is around $1500.")
    ]

    static let text = "Great! I recommend the XYZ laptop. It has a powerful GPU for gaming and a fast CPU for programming. It's priced at $1499. Would you like more details?"
    
    static let encouragingTone = AITone(
        name: "Encouraging",
        description: "This tone would be useful for motivation and encouragement. It would include positive words, affirmations, and express support and belief in the recipient.",
        icon: "💪"
    )
    
    static let professionalTone = AITone(
        name: "Professional",
        description: "This would edit messages to sound more formal, using technical vocabulary, clear sentence structures, and maintaining a respectful tone. It would avoid colloquial language and ensure appropriate salutations and sign-offs.",
        icon: "👔"
    )
}
