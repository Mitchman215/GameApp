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
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                header()
                
                Divider()
            
                gameBody
                
                deckBody
                
                shuffle
            }
            deckBody
        }
        .padding()
    }
    
    //MARK: Game View
    var gameBody: some View {
        AspectVGrid(items: theGame.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                ConcentrationCardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(CardConstants.betweenCardsPadding)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            theGame.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(theGame.color)
    }
    
    // MARK: Shuffle Button
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                theGame.shuffle()
            }
        }
    }
    
    // MARK: New Game Button
    var newGameButton: some View {
        Button {
            withAnimation {
                dealt = []
                theGame.startNewGame()
            }
        } label: {
            VStack {
                Image(systemName: "plus.circle").font(.title)
                Text("New Game").font(.subheadline)
            }
        }
    }
    
    // MARK: Header
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
                newGameButton
            }
            .padding(.horizontal)
        }
    }
    
    //MARK: Deck
    var deckBody: some View {
        ZStack {
            ForEach(theGame.cards.filter(isUndealt)) { card in
                ConcentrationCardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(theGame.color)
        .onTapGesture {
            // "deal" cards
            for card in theGame.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    // MARK: Dealing Animation Functionality
    /// Termporary state variable that keeps tracks of which cards (by id) have been dealt out
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiConcentration.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiConcentration.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiConcentration.Card) -> Animation {
        var delay = 0.0
        if let index = theGame.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(theGame.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiConcentration.Card) -> Double {
        -Double(theGame.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    // MARK: Card Constants
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let betweenCardsPadding: CGFloat = 4
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}



/// The view for displaying a specific concentration game card
struct ConcentrationCardView: View {
    private let card: EmojiConcentration.Card
    
    init(_ card: EmojiConcentration.Card) {
        self.card = card
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
                    }
                }
                .padding(DrawingConstants.backCirclePadding)
                .opacity(DrawingConstants.backCircleOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched  ? 360 : 0))
                    .animation(Animation.easeInOut(duration: 1), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geo.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height / (DrawingConstants.fontSize / DrawingConstants.fontScale))
    }
    
    private struct DrawingConstants {
        static let backCirclePadding: CGFloat = 5
        static let backCircleOpacity: CGFloat = 0.5
        static let fontScale: CGFloat = 0.4
        static let fontSize: CGFloat = 32
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
