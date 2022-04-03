//
//  SetView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/25/22.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var theGame = SetViewModel()
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                header
                
                Divider()
                
                gameBody
                    .padding(.horizontal)
            }
            deckBody
        }
    }
    
    var header: some View {
        VStack {
            Text("Set!")
                .bold()
                .font(.largeTitle)
            
            HStack {
                Button {
                    theGame.deal()
                } label: {
                    buttonLabel(sfImage: "plus.square.fill.on.square.fill", text: "Deal Cards")
                }

                Spacer()
                
                Text("Score: _")
                    .font(.title2)
                
                Spacer()
                
                Button {
                    theGame.startNewGame()
                } label: {
                    buttonLabel(sfImage: "plus.circle", text: "New Game")
                }
            }
            .padding(.horizontal)
        }
    }
    
    var gameBody: some View {
        AspectVGrid(items: theGame.selectableCards, aspectRatio: Constants.cardAspectRatio) { card in
            SetCardView(card)
                .foregroundColor(theGame.cardStrokeColor(card))
                .padding(Constants.paddingBetweenCards)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(of: card, in: theGame.selectableCards))
                .onTapGesture {
                    theGame.touch(card)
                }
        }
    }
    
    // MARK: Deck
    var deckBody: some View {
        ZStack {
            ForEach(theGame.deckCards) { card in
                SetCardView(card, isFaceUp: true)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
                    .zIndex(zIndex(of: card, in: theGame.deckCards))
            }
        }
        .frame(width: Constants.deckWidth, height: Constants.deckHeight)
        .foregroundColor(Constants.deckColor)
        .onTapGesture {
            // "deal" cards
            withAnimation(dealAnimation()) {
                theGame.deal()
            }
        }
    }
    
    private func buttonLabel(sfImage: String, text: String) -> some View {
        VStack {
            Image(systemName: sfImage).font(.title)
            Text(text).font(.subheadline)
        }
    }
    
    private struct Constants {
        static let cardAspectRatio: CGFloat = 3/2
        static let paddingBetweenCards: CGFloat = 4
        static let deckHeight: CGFloat = 90
        static let deckWidth = deckHeight * cardAspectRatio
        static let deckColor: Color = .red
        
        static let dealDuration: Double = 2
        static let dealDelay: Double = 0.2
    }
    
    private func dealAnimation() -> Animation {
        return Animation.easeInOut(duration: Constants.dealDuration)
    }
    
    /// Returns the zIndex of the card in the list, or 0 if the card isn't in the list. Larger indices are to be placed in front of smaller indices.
    private func zIndex(of card: SetGame.Card, in list: [SetGame.Card]) -> Double {
        -Double(list.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
}


struct SetCardView: View {
    private let card: SetGame.Card
    private let faceUp: Bool
    
    init(_ card: SetGame.Card, isFaceUp: Bool = true) {
        self.card = card
        self.faceUp = isFaceUp
    }
    
    @ViewBuilder
    private var strokedSymbol: some View {
        switch card.shape {
        case .zero: Diamond().stroke()
        case .one: Rectangle().stroke()
        case .two: Capsule().stroke()
        }
    }
    
    @ViewBuilder
    private var filledSymbol: some View {
        switch card.shape {
        case .zero: Diamond().fill()
        case .one: Rectangle().fill()
        case .two: Capsule().fill()
        }
    }
    
    private var shadedSymbol: some View {
        ZStack {
            strokedSymbol
            filledSymbol.opacity(Constants.shadedOpacity)
        }
    }
    
    private var color: Color {
        switch card.color {
        case .zero: return .blue
        case .one: return .green
        case .two: return .pink
        }
    }
    
    @ViewBuilder
    private var symbols: some View {
        HStack {
            ForEach(-1..<card.number.val) { _ in
                switch card.shading {
                case .zero: strokedSymbol.aspectRatio(Constants.symbolAspectRatio, contentMode: .fit)
                case .one: shadedSymbol.aspectRatio(Constants.symbolAspectRatio, contentMode: .fit)
                case .two: filledSymbol.aspectRatio(Constants.symbolAspectRatio, contentMode: .fit)
                }
            }
            
        }
        .padding(Constants.symbolPadding)
        .foregroundColor(color)
    }
    
    
    var body: some View {
        symbols.cardify(isFaceUp: faceUp)
    }
    
    private struct Constants {
        static let shadedOpacity: CGFloat = 0.3
        static let symbolAspectRatio: CGFloat = 1/2
        static let symbolPadding: CGFloat = 7
    }
}



struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetViewModel()
        SetView(theGame: game)
    }
}
