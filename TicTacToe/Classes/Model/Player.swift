//
//  Player.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Foundation

enum PlayerMode {
    case Human, Computer
}


class Player {
    var mode: PlayerMode
    var moves: [Int] = []
    
    init(mode: PlayerMode = .Human) {
        self.mode = mode
    }
    
}