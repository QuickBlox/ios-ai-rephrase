//
//  Tone.swift
//
//  Created by Injoit on 07.09.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import Foundation

public protocol Tone: Codable, Equatable, Hashable {
    var name: String { get }
    var description: String { get }
    var icon: String? { get }
}

public extension Tone {
    static func == (lhs: Self, rhs: Self) -> Bool {
      return lhs.name == rhs.name
    }
}



public struct AITone: Tone {
    public let name: String
    public let description: String
    public private(set) var icon: String? = nil
    
    public init(name: String,
                description: String,
                icon: String? = nil) {
        self.name = name
        self.description = description
        self.icon = icon
    }
}
