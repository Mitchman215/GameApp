//
//  EmojiConcentration.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/21/22.
//

import SwiftUI

class EmojiConcentration: ObservableObject {
    typealias Card = Concentration<String>.Card
    
    private(set) var selectedTheme: Theme
    @Published private var model: Concentration<String>
    var cards: [Card] {
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
        model = EmojiConcentration.createNewGame(with: selectedTheme)
    }
    
    convenience init() {
        self.init(with: Theme.defaults.randomElement()!)
    }
    
    static func createNewGame(with theme: Theme) -> Concentration<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        return Concentration(numberOfPairsOfCards: theme.numberOfStartingPairs) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        selectedTheme = Theme.defaults.randomElement()!
        model = EmojiConcentration.createNewGame(with: selectedTheme)
    }
}
