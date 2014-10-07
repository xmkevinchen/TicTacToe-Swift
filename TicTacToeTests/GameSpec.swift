//
//  GameSpec.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Quick
import Nimble

class GameSpec: QuickSpec {

    override func spec() {
        describe("game spec") {
            it("it's a game") {
                expect(true).to(beTruthy())
            }
        }
    }
}
