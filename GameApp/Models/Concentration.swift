//
//  Concentration.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/17/22.
//

import Foundation

/// A 1-player game of concentration with a generic card content type
struct Concentration<CardContent> where CardContent: Equatable {
    /// All the cards of the Concentration game
    private(set) var cards: [Card]
    
    /// The index of the only face up card currently in the game. If there aren't any face up cards or if two are face up, is nil
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    /// Variables to conform with Game
    private(set) var score = 0
    
    /// Create a concentration game with the specified number of pairs of cards.
    /// `createCardContent` is used to create unique content for each pair index passed in
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        var cards: [Card] = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        self.cards = cards.shuffled()
    }
    
    /// Handles the logic of selecting a card and playing concentration.
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // Two cards are selected, determine if they are a match
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Cards are matched. Adds 2 points
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    // Cards are not matched. Subtracts 1 one point for each card previously seen
                    if cards[chosenIndex].previouslySeen {
                        score -= 1
                    }
                    if cards[potentialMatchIndex].previouslySeen {
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].previouslySeen = true
                cards[potentialMatchIndex].previouslySeen = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    /// Shuffles the cards
    mutating func shuffle() {
        cards.shuffle()
    }
    
    /// Represents an individual card in Concentration
    struct Card: Identifiable {
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
        var previouslySeen = false
        let id: Int
    }
}

extension Array {
    /// If and only if the array contains a single element, return that element. Otherwise, return nil.
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
