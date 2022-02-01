//
//  EmojiConcentrationView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/15/22.
//

import SwiftUI

/// The view for an emoji concentration game
struct EmojiConcentrationView: View {
    @ObservedObject var theGame: EmojiConcentration
    
    var body: some View {
        VStack {
            header()
        
            AspectVGrid(items: theGame.cards, aspectRatio: Constants.aspectRatio) { card in
                ConcentrationCardView(card)
                    .padding(Constants.betweenCardsPadding)
                    .onTapGesture { theGame.choose(card) }
            }
            .foregroundColor(theGame.color)
        }
        .padding(.horizontal)
    }
    
    /// Returns the UI for the title, score, and new game button
    private func header() -> some View {
        VStack {
            Text("Match the \(theGame.selectedTheme.name)!")
                .bold()
                .font(.largeTitle)
            
            HStack {
                Text("Score: \(theGame.score)")
                    .font(.title2)
                Spacer()
                Button {
                    theGame.startNewGame()
                } label: {
                    VStack {
                        Image(systemName: "plus.circle").font(.title)
                        Text("New Game").font(.subheadline)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let betweenCardsPadding: CGFloat = 4
    }
}



/// The view for displaying a specific concentration game card
struct ConcentrationCardView: View {
    private let card: EmojiConcentration.Card
    
    init(_ card: EmojiConcentration.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 30))
                    .padding(DrawingConstants.backCirclePadding)
                    .opacity(DrawingConstants.backCircleOpacity)
                Text(card.content).font(font(in: geo.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let backCirclePadding: CGFloat = 5
        static let backCircleOpacity: CGFloat = 0.5
        static let fontScale: CGFloat = 0.7
    }
}




struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiConcentration()
        game.choose(game.cards.first!)
        return EmojiConcentrationView(theGame: game)
//        EmojiMemoryGameView(theGame: game)
//            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
