//
//  Memory.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/17/22.
//

import Foundation

struct MemoryGame<CardContent> {
    
    private(set) var cards: [Card]
    
    var score = 0
    
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
    
    // TODO: implement
    func choose(_ card: Card) {
        
    }
    
    
    struct Card {
        let content: CardContent
        var isFaceUp = false
        var isMatched = false
        let id: Int
    }
}
