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
        model.selectable
    }
    
    func cardStrokeColor(_ card: Card) -> Color {
        if model.selected.contains(card) {
            if model.selectedAreMatch == nil {
                return .blue
            } else if model.selectedAreMatch! {
                return .green
            } else {
                return .red
            }
        } else {
            return .black
        }
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
    
    func touch(_ card: Card) {
        model.touch(card)
    }
    
    func deal() {
        model.standardDeal()
    }
    
    
    func startNewGame() {
        model = SetGame();
    }
}
