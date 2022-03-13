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
    private(set) var score: Double = 0
    
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
                    // Cards are matched. Add points for matching
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += GameConstants.flatMatchScore
                    // add bonus points, if there are any
                    score += calculateBonusPoints(for: cards[chosenIndex])
                    score += calculateBonusPoints(for: cards[potentialMatchIndex])
                } else {
                    // Cards are not matched. Subtracts 1 one point for each card previously seen
                    if cards[chosenIndex].previouslySeen {
                        score -= GameConstants.previouslySeenPenalty
                    }
                    if cards[potentialMatchIndex].previouslySeen {
                        score -= GameConstants.previouslySeenPenalty
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
    
    private func calculateBonusPoints(for card: Card) -> Double {
        if card.hasEarnedBonus {
            return GameConstants.baseBonusScore * GameConstants.bonusMaxScalar * card.bonusRemaining
        } else {
            return 0
        }
    }
    
    /// Shuffles the cards
    mutating func shuffle() {
        cards.shuffle()
    }
    
    /// Represents an individual card in Concentration
    struct Card: Identifiable {
        let content: CardContent
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingbonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var previouslySeen = false
        let id: Int
        
        // MARK: Bonus Time
        
        // gives matching bonus points if the user matches the card
        // before a certain amount of time passes while the card is face up
        
        // can be zero, which means "no bonus available"
        var bonusTimeLimit: TimeInterval = CardConstants.defaultBonusTimeLimit
        
        // the last time this card was face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is already so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched, and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up stat
        private mutating func startUsingbonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}

private struct GameConstants {
    static let flatMatchScore: Double = 2
    static let baseBonusScore: Double = 1
    static let bonusMaxScalar: Double = 1
    static let previouslySeenPenalty: Double = 1
}

private struct CardConstants {
    static let defaultBonusTimeLimit: TimeInterval = 6
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
