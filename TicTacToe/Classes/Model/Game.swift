//
//  Game.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Foundation

enum GameMode {
    case Computer, Player, Auto
}


class Game {
    var mode: GameMode
    var playerX: Player     // Always the first player
    var playerO: Player     // Always the second player
    var board: GameBoard
    
    init(mode: GameMode = .Computer) {
        self.mode = mode
        self.board = GameBoard()
        
        switch mode {
        case .Computer:
            self.playerX = Player()
            self.playerO = Player(type: .Computer)
            
        case .Player:
            self.playerX = Player()
            self.playerO = Player()
            
        case .Auto:
            // TODO: play game automatically with two computer player
            self.playerX = Player(type: .Computer)
            self.playerO = Player(type: .Computer)
            
        default:
            break;
        }
    }
    
    func reset() {
        board.reset()
        
    }        
}