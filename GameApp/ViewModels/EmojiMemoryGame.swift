//
//  EmojiMemoryGame.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/21/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private(set) var selectedTheme: Theme
    @Published private var model: MemoryGame<String>
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    var score: Int {
        model.score
    }
    
    private let colorsDictionary: [String: Color] = [
        "white": .white, "orange": .orange, "red": .red, "black": .black, "blue": .blue, "purple": .purple,
        "brown": .brown, "yellow": .yellow, "green": .green, "gray": .gray, "pink": .pink, "cyan": .cyan]
    var color: Color {
        colorsDictionary[selectedTheme.color] ?? .gray
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
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        selectedTheme = Theme.defaults.randomElement()!
        model = EmojiMemoryGame.createNewGame(with: selectedTheme)
    }
}
