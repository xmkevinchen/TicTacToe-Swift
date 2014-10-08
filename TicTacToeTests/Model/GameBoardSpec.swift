//
//  GameBoardSpec.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Quick
import Nimble
import TicTacToe

class GameBoardSpec: QuickSpec {

    override func spec() {
        describe("GameBoard basic properties") {
            it("init game board") {
                var board = GameBoard()
                for square in board.matrix {
                    expect(square == .Empty).to(beTruthy())
                }
            }
        }
    }
}
