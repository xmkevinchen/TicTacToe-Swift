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

enum SquareType:String {
    case Empty  = "-"
    case Cross  = "X"
    case Circle = "O"
}

let GameBoardSize = 9

class Game {
    var mode: GameMode
    var playerX: Player     // Always the first player
    var playerO: Player     // Always the second player
    var board: [SquareType]
    var moves: [Int] = []
    
    init(mode: GameMode = .Auto) {
        self.mode = mode
        self.board = [SquareType](count: GameBoardSize, repeatedValue: .Empty)
        
        switch mode {
        case .Computer:
            self.playerO = Player(mode: .Computer)
            self.playerX = Player()
            
            
        case .Player:
            self.playerX = Player()
            self.playerO = Player()
            
        case .Auto:
            // TODO: play game automatically with two computer player
            self.playerX = Player(mode: .Computer)
            self.playerO = Player(mode: .Computer)
            
        default:
            break;
        }
    }
    
    func setMode(mode: GameMode) {
        self.mode = mode
    }
    
    
    
    
    func reset() {
        board = [SquareType](count: GameBoardSize, repeatedValue: .Empty)
        playerX.moves.removeAll(keepCapacity: false)
        playerO.moves.removeAll(keepCapacity: false)
        moves.removeAll(keepCapacity: false)
        
    }        
}