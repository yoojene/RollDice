//
//  GameResults.swift
//  RollDice
//
//  Created by Eugene on 09/10/2023.
//

import Foundation

struct GameResults: Identifiable, Codable {
    let id: UUID
    let rollResult: Int
    
    static let example = GameResults(id: UUID(), rollResult: 1)
    static let example2 = GameResults(id: UUID(), rollResult: 6)
}
