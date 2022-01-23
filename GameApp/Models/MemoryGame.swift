//
//  Memory.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/17/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var tempIndexOfFaceUpCard: Int?
    
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        var cards: [Card] = []
        // Fills the cards array with pairs of cards with content determined by `createCardContent`
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        self.cards = cards.shuffled()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = tempIndexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Cards are matched
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    // Cards are not matched
                    score -= 1
                }
                tempIndexOfFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                tempIndexOfFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    
    struct Card: Identifiable {
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
        let id: Int
    }
}
