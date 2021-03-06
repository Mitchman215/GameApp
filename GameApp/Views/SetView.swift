//
//  SetView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/25/22.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var theGame = SetViewModel()
    
    var body: some View {
        VStack {
            header()
            
            Divider()
            
            AspectVGrid(items: theGame.selectableCards, aspectRatio: Constants.cardAspectRatio) { card in
                SetCardView(card)
                    .foregroundColor(theGame.cardStrokeColor(card))
                    .padding(Constants.paddingBetweenCards)
                    .onTapGesture {
                        theGame.touch(card)
                    }
            }
            .padding(.horizontal)
        }
    }
    
    private func header() -> some View {
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
    
    private func buttonLabel(sfImage: String, text: String) -> some View {
        VStack {
            Image(systemName: sfImage).font(.title)
            Text(text).font(.subheadline)
        }
    }
    
    private struct Constants {
        static let cardAspectRatio: CGFloat = 3/2
        static let paddingBetweenCards: CGFloat = 4
    }
}


struct SetCardView: View {
    private let card: SetGame.Card
    
    init(_ card: SetGame.Card) {
        self.card = card
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
        symbols.cardify()
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
