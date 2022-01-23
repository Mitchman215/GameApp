//
//  EmojiMemoryGame.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/21/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    let selectedTheme: Theme
    @Published private var model: MemoryGame<String>
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    private init(with theme: Theme) {
        selectedTheme = theme
        model = EmojiMemoryGame.createNewGame(with: selectedTheme)
    }
    
    convenience init() {
        self.init(with: Theme.defaults.randomElement()!)
    }
    
    static func createNewGame(with theme: Theme) -> MemoryGame<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        return MemoryGame(numberOfPairsOfCards: theme.numberOfStartingPairs) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }
    
    
    static func colorize(colorName: String) -> Color {
        return Color(colorName)
    }
    
    // MARK: - Intent(s)
    func chose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
