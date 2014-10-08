//
//  Gameboard.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Foundation
enum GameSquareType {
    case Empty, Cross, Circle
}

let GameBoardSize = 9

class GameBoard {
    
    var matrix: [GameSquareType]
    
    init() {
        self.matrix = []
        for i in 0..<GameBoardSize {
            self.matrix.append(.Empty)
        }
    }
    
    func reset() {
        self.matrix.removeAll(keepCapacity: true)
        for i in 0..<GameBoardSize {
            self.matrix.append(.Empty)
        }
    }
}