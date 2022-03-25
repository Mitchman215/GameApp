//
//  GameModel.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/5/22.
//

import Foundation

class GameController: ObservableObject {
    
    @Published var currentGame: AvailableGames?
}
