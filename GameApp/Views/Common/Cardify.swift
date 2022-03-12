//
//  Cardify.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/26/22.
//

import SwiftUI

/// A ViewModifier that puts the specified view onto a card that can be flipped over with an animation
struct Cardify: Animatable, ViewModifier {
    
    init(isFaceUp: Bool, backgroundColor: Color = .white) {
        rotation = isFaceUp ? 0 : 180
        self.backgroundColor = backgroundColor
    }
    
    /// The background color when the card is flipped over
    var backgroundColor: Color
    
    /// The degrees that the card has been flipped, ranging from 0 to 180
    var rotation: Double // in degrees
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(backgroundColor)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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

