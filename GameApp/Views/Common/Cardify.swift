//
//  Cardify.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/26/22.
//

import SwiftUI

/// A ViewModifier that puts the specified view onto a card that can be flipped over
struct Cardify: ViewModifier {
    /// Whether the card is flipped over
    var isFaceUp: Bool
    
    /// The background color when the card is flipped over
    var backgroundColor: Color = .white
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(backgroundColor)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool = true, backgroundColor: Color = .white) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, backgroundColor: backgroundColor))
    }
}

