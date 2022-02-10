//
//  SetViewModel.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/26/22.
//

import SwiftUI

class SetViewModel: ObservableObject {
    typealias Card = SetGame.Card
    @Published private var model = SetGame()
    var selectableCards: [Card] {
        Array(model.selectable)
    }
    
    @ViewBuilder
    static func displayCardContent(_ card: Card) -> some View {
        switch card.shape {
        case .zero: Diamond()
        case .one: Rectangle()
        case .two: Capsule()
        }
    }
    
    
    // MARK: - Intents
    
    func select(_ card: Card) {
        
    }
    
    func deal() {
        model.dealCards(howMany: 3)
    }
    
    
    func startNewGame() {
        model = SetGame();
    }
}
