//
//  EmojiMemoryGame.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/21/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    static func createNewGame(with theme: theme) -> MemoryGame<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        return MemoryGame(numberOfPairsOfCards: theme.numberOfStartingPairs) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }
    
    // MARK: - Themes
    struct theme {
        let name: String
        let emojis: [String]
        let numberOfStartingPairs: Int
        let color: Color
    }
    
    static let AVAILABLE_THEMES = [
        theme(name: "Vehicles", emojis: ["🚕", "🚗", "🚙", "🚌", "🚎", "🏎", "🚜", "🚑"],
              numberOfStartingPairs: 8, color: .orange)
    ]
    
    // MARK: - Intent(s)
    func chose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
