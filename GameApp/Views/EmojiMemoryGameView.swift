//
//  EmojiMemoryGameView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/15/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var theGame: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize \(theGame.selectedTheme.name)!")
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
        
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(theGame.cards) { card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                theGame.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(theGame.color)
        }
        .padding(.horizontal)
    }
}



struct CardView: View {
    private let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geo.size))
                } else if card.isMatched{
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}




struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemoryGame()
        EmojiMemoryGameView(theGame: viewModel)
        EmojiMemoryGameView(theGame: viewModel)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
