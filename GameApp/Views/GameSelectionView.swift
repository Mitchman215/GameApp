//
//  GameSelectionView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/5/22.
//

import SwiftUI

/// The view for selecting a game
// TODO: Add functionality to actually start and navigate to the games when the user clicks on them
struct GameSelectionView: View {
    var body: some View {
        VStack {
            Text("Select a game to play")
                .bold()
                .padding(.top)
                .font(.title)
        
                AspectVGrid(items: AvailableGames.allCases, aspectRatio: 1) { game in
                    ZStack(alignment: .bottom) {
                        Image(game.imageName)
                            .resizable()
                            .opacity(Constants.imageOpacity)
                            .cornerRadius(Constants.imageCornerRadius)
                        
                        Text(game.name)
                            .bold()
                            .font(.title2)
                    }
                    .padding(Constants.paddingBetweenGames)
                }
        }
    }
    
    private struct Constants {
        static let imageOpacity = 0.6
        static let imageCornerRadius: CGFloat = 20
        static let paddingBetweenGames: CGFloat = 4
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectionView()
    }
}
