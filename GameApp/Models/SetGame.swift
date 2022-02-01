//
//  SetGame.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/25/22.
//

import Foundation

/// A singleplayer game of Set
struct SetGame {
    /// The cards currently in the deck
    private var deck: Set<Card>
    
    /// The revealed cards that can be selected by players
    private(set) var selectable: Set<Card>
    
    /// Cards currently selected by the player
    var selected: Set<Card> {
        selectable.filter { $0.isSelected }
    }
    
    /// Returns a set containing all the 81 possible configuration of cards
    private static var allCards: Set<Card> {
        var cards: Set<Card> = []
        for shape in Trilean.allCases {
            for color in Trilean.allCases {
                for shading in Trilean.allCases {
                    for number in Trilean.allCases {
                        cards.insert(Card(shape: shape, color: color, shading: shading, number: number))
                    }
                }
            }
        }
        return cards
    }
    
    /// The number of cards that start off selectable when the game is created
    private static let numberOfStartingCards = 12
    
    /// Starts a game of Set
    init() {
        deck = SetGame.allCards
        selectable = []
        dealCards(howMany: SetGame.numberOfStartingCards)
    }
    
    /// Attempts to move the specified number of random cards from `deck` to `selectable`
    mutating func dealCards(howMany numCards: Int) {
        for _ in 0..<numCards {
            if let toDeal = deck.randomElement() {
                selectable.insert(deck.remove(toDeal)!)
            } else {
                print("Deck out of cards to deal")
                break
            }
        }
    }
    
    
    mutating func touch(_ card: Card) {
        if isMatchingSet(cards: selected) {
            selectable = selectable.filter { !$0.isSelected }
            dealCards(howMany: 3)
            select(card)
        } else if selected.count == 3 {
            selected.forEach { deselect($0) }
            
        }
    }
    
    /// Performs all the logic of selecting a card
    mutating func select(_ card: Card) {
        if var selectedCard = selectable.remove(card) {
            selectedCard.isSelected = true
            selectable.insert(selectedCard)
        }
    }
    
    private func deselect(_ card: Card) {
        
    }
    
    /// Determines if the passed in cards form a set according to the rules of Set
    private func isMatchingSet(cards: Set<Card>) -> Bool {
        let threeCards = cards.count == 3
        let validShapes = allOrNoneEqual(cards.map(\.shape))
        let validColor = allOrNoneEqual(cards.map(\.color))
        let validShading = allOrNoneEqual(cards.map(\.shading))
        let validNumber = allOrNoneEqual(cards.map(\.number))
        return threeCards && validShapes && validColor && validShading && validNumber
    }
    
    /// Returns true if either all the items are equal or none of them are equal to each other; returns false otherwise
    private func allOrNoneEqual<Item: Hashable>(_ items: Item...) -> Bool {
        let itemsAsSet = Set(items)
        return (itemsAsSet.count == 1) || (itemsAsSet.count == items.count)
    }
    
    /// An individual card in a game of Set
    struct Card: Identifiable, Hashable {
        
        /// The shape on the card
        let shape: Trilean
        
        /// The color of the shape(s) on the card
        let color: Trilean
        
        /// The shading of the shape(s) on the card
        let shading: Trilean
        
        /// The number of shapes on the card
        let number: Trilean
        
        /// Returns a string that represents one of the 81 possible configurations of the four properties
        var id: Int {
            number.val + (shading.val * 3) + (color.val * 9) + (shape.val * 27)
        }
        
        /// Whether the card is selected
        var isSelected = false
    }
}

extension String {
    /// Returns the string with an "s" appended to the end of it if the condition is true
    func pluralized(_ condition: Bool = true) -> String {
        self.appending(condition ? "s" : "")
    }
}


/// A data structure that has three possible states
enum Trilean: Int, CaseIterable {
    case zero, one, two
    var val: Int { self.rawValue }
}
