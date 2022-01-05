//
//  Game.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/5/22.
//

import Foundation

enum AvailableGames: String, CaseIterable {
    case ticTacToe = "Tic-Tac-Toe"
    case connect4 = "Connect Four"
    case chess = "Chess"
    
    func getName() -> String {
        self.rawValue
    }
}

struct Game {
    let type: AvailableGames
    let player1: String = "Player 1"
    let player2: String = "Player 2"
    
    
}
