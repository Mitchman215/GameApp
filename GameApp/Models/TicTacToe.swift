//
//  TicTacToe.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/10/22.
//

import Foundation

final class ticTacToe: TwoPlayerBoardGame {
    let gameType: AvailableGames = .ticTacToe
    
    let player0Name: String
    
    let player1Name: String
    
    var board: [[Piece?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    
    var whoseTurn: Player = .player0
    
    
    init(
}
