//
//  GameProtocol.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/5/22.
//

import Foundation

/// All the available games in the app
enum AvailableGames: String, CaseIterable, Identifiable {
    case ticTacToe = "Tic-Tac-Toe"
    case connect4 = "Connect Four"
    case chess = "Chess"
    case concentration = "Concentration"
    case set = "Set"
    
    var name: String { self.rawValue }
    var id: String { name }
    var imageName: String { name }
    /// A short description of the rules for each game
    var description: String {
        switch self {
        case .ticTacToe:
            return """
                    Tic-Tac-Toe is a 2 player game where each player takes turns placing either X's or O's on a 3x3 grid.
                    The first player to get 3 of their marks in a row diagonally, horizontally, or vertically wins.
                    If the entire grid is filled, the game is a draw.
                    """
        case .connect4:
            return """
                    Connect Four is a 2 player game where each player takes turn dropping colored discs into a 6x7 suspended grid.
                    The first player to get 5 of their discs in a row diagonally, horizontally, or vertically wins.
                    If the entire grid is filled, the game is a draw.
                    """
        case .chess:
            return """
                    Chess is a 2 player strategy game played on a 8x8 grid. The players take turns moving their pieces (either
                    white or black). Each of the different types of pieces have their own rules for moving and can capture
                    their opponents pieces.
                    In order to win, one player must checkmate the other by threatening to capture their king
                    and preventing the king from being able to escape.
                    """
        case .concentration:
            return """
                    Memorize is a singleplayer game where pairs of face-down cards must be matched with each other.
                    A maximum of two cards can be face up at one time, and if a match is not established between those two cards,
                    they will be flipped over again. The goal is to match all the cards in the shortest time.
                    """
        default: return "Description not set"
        }
    }
}

// TODO: To be expaned in the future
protocol GameProtocol {
    var score: Double { get }
    // TODO: make player model to replace
    var player0Name: String { get }
}
