//
//  Player.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Foundation

enum PlayerType {
    case Human, Computer
}

class Player {
    var type: PlayerType
    
    init(type: PlayerType = .Human) {
        self.type = type
    }
    
}