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
                var player = Player()
                expect(player.type == .Human).to(beTruthy())
            }
            
            it("it's a computer player") {
                var player = Player(type: .Computer)
                expect(player.type == .Computer).to(beTruthy())
            }
        }
    }
}
