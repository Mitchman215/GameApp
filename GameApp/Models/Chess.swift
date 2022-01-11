//
//  Chess.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/9/22.
//

import Foundation

enum ChessPieceType {
    case pawn
    case knight
    case bishop
    case rook
    case queen
    case king
}

final class ChessPiece: Piece {
    let type: ChessPieceType
    
    init(player: Player, type: ChessPieceType) {
        self.type = type
        super.init(player: player)
    }
}

class Chess: TwoPlayerBoardGame {
    let gameType: AvailableGames = .chess
    
    let player0Name: String
    
    let player1Name: String
    
    var board: [[Piece?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    
    var whoseTurn: Player
    
    
    init(whitePlayerName: String, blackPlayerName: String) {
        
    }
}
