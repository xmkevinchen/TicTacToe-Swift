//
//  PlayerSpec.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Quick
import Nimble

class PlayerSpec: QuickSpec {
    
    override func spec() {
        describe("Player Basic property") {
            it("it's human player by default") {
                var player = Player(type: .XType)
                expect(player.mode == .Human).to(beTruthy())
            }
            
            it("it's a computer player") {
                var player = Player(mode: .Computer, type: .XType)
                expect(player.mode == .Computer).to(beTruthy())
            }
        }
    }
}
