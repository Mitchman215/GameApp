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
    private var deck: Set<Card> = SetGame.allCards
    
    /// The revealed cards that can be selected by players
    private(set) var selectable: [Card] = []
    
    /// The 0 - 3 cards that are currently selected
    private(set) var selected: Set<Card> = []
    
    /// Is true if 3 matching cards are selected, false if 3 cards that don't match are selected, nil otherwise
    var selectedAreMatch: Optional<Bool> {
        selected.count == 3 ? isMatchingSet(cards: selected) : nil
    }
    
    /// Cards that have been matched and thus are out of the game
    private var matched: Set<Card> = []
    
    
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
    
    /// Starts a game of Set, dealing out the appropriate number of starting cards
    init() {
        dealCards(howMany: SetGame.numberOfStartingCards)
    }
    
    /// Attempts to move the specified number of random cards from `deck` to `selectable`
    private mutating func dealCards(howMany numCards: Int) {
        for _ in 0..<numCards {
            if let toDeal = deck.randomElement() {
                selectable.append(deck.remove(toDeal)!)
            } else {
                print("Deck out of cards to deal")
                break
            }
        }
    }
    
    /// The amount of cards usually dealed at once
    private static let standardDealSize = 3
    /// Deal the standard amount of cards
    mutating func standardDeal() {
        dealCards(howMany: 3)
    }
    
    /// Simulates when a player tries to touch a card to select it.
    mutating func touch(_ card: Card) {
        if selectedAreMatch == nil { // less than 3 cards selected
            if selected.contains(card) { deselect(card) }
            else { select(card) }
        } else if selectedAreMatch! { // there are already 3 matching cards selected
            // replace those 3 matching cards with new ones from the deck
            selectable = selectable.filter { !selected.contains($0) }
            standardDeal()
            
            // deselect each selected card and move them into `matched`
            selected.forEach { card in
                deselect(card)
                matched.insert(card)
            }
            
            // if touched card was not part of the matching set, select it
            if !matched.contains(card) { select(card) }
        } else { // 3 non matching cards selected
            selected.forEach { deselect($0) }
            select(card)
        }
        
    }
    
    /// Selects a card
    private mutating func select(_ card: Card) {
        selected.insert(card)
        assert(selected.count <= 3, "More than 3 cards selected at once")
    }
    
    /// Deselects a card
    private mutating func deselect(_ card: Card) {
        selected.remove(card)
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
        
        /// Returns a unique int that represents one of the 81 possible configurations of the four card properties
        var id: Int {
            number.val + (shading.val * 3) + (color.val * 9) + (shape.val * 27)
        }
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
