//
//  EmojiConcentration.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/21/22.
//

import SwiftUI

/// A view model used to represent a concentration game with emojis based on a theme
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
    
    /// Dictionary used to convert the color names stored in themes to Color objects
    private let colorsDictionary: [String: Color] = [
        "white": .white, "orange": .orange, "red": .red, "black": .black, "blue": .blue, "purple": .purple,
        "brown": .brown, "yellow": .yellow, "green": .green, "gray": .gray, "pink": .pink, "cyan": .cyan]
    /// Returns the color of the selected theme, defaulting to gray if the color name is not in the dictionary
    var color: Color {
        colorsDictionary[selectedTheme.color] ?? .gray
    }
    
    /// Create an emoji concentration game with a specific theme
    private init(with theme: Theme) {
        selectedTheme = theme
        model = EmojiConcentration.createNewGame(with: selectedTheme)
    }
    
    /// Create an emoji concentration game with a random theme chosen from the defaults
    convenience init() {
        self.init(with: Theme.defaults.randomElement()!)
    }
    
    /// Creates the actual concentration game model given a theme
    static func createNewGame(with theme: Theme) -> Concentration<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        return Concentration(numberOfPairsOfCards: theme.numberOfStartingPairs) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }
    
    // MARK: - Intents
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        selectedTheme = Theme.defaults.randomElement()!
        model = EmojiConcentration.createNewGame(with: selectedTheme)
    }
}
