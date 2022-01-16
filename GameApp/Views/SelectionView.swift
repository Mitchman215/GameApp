//
//  SelectionView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/5/22.
//

import SwiftUI

struct SelectionView: View {
    var body: some View {
        VStack {
            Text("Select a game to play")
                .bold()
                .padding(.top, 40)
                .font(.title)
        
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20, alignment: .top),
                                    GridItem(.flexible(), spacing: 20, alignment: .top)],
                          alignment: .center, spacing: 20) {
                    
                    ForEach(AvailableGames.allCases, id: \.self) { game in
                        VStack {
                            Image(game.imageName)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                }
            }
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}
