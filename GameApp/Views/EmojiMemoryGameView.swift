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
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched{
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
        
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
