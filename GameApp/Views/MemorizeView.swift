//
//  MemorizeView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/15/22.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text("Memorize \(viewModel.selectedTheme.name)!")
                    .bold()
                    .font(.title)
                
                Button {
                    viewModel.startNewGame()
                } label: {
                    VStack {
                        Image(systemName: "plus.circle").font(.title)
                        Text("New Game").font(.subheadline)
                    }
                }
            }
        
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.color)
        }
        .padding(.horizontal)
    }
}



struct CardView: View {
    let card: MemoryGame<String>.Card
    
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
        MemorizeView(viewModel: viewModel)
        MemorizeView(viewModel: viewModel)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
