//
//  GameSelectionView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/5/22.
//

import SwiftUI

struct GameSelectionView: View {
    var body: some View {
        VStack {
            Text("Select a game to play")
                .bold()
                .padding(.top, 40)
                .font(.title)
        
                AspectVGrid(items: AvailableGames.allCases, aspectRatio: 1) { game in
                    ZStack(alignment: .bottom) {
                        Image(game.imageName)
                            .resizable()
                            .opacity(0.6)
                            .cornerRadius(20)
                        
                        Text(game.name)
                            .bold()
                            .font(.title2)
                    }
                    .padding(4)
                }
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectionView()
    }
}
