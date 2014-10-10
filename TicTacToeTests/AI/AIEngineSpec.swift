//
//  AIEngineSpec.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/10/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Quick
import Nimble

class AIEngineSpec: QuickSpec {

    override func spec() {
        describe("AI Engine") {
            
            var ai: AIEngine!
            
            beforeEach() {
                ai = AIEngine(game: Game())
            }
            
            describe("Basic judgement") {
                it("isWin") {
                    
                    for var i = 0; i < ai.wins.count; i++ {
                        
                        let indices = ai.wins[i]
                        var board: [SquareType] = [SquareType](count: GameBoardSize, repeatedValue: .Empty)
                        let square: SquareType = (i % 2 == 0) ? .Cross : .Circle
                        for index in indices {
                            board[index] = square
                        }
                        
                        expect(ai.isWin(board)).to(beTruthy())
                    }
                }
                
                it("isDraw") {
                    let board: [SquareType] = [
                        .Circle, .Circle, .Cross,
                        .Cross,  .Cross,  .Circle,
                        .Circle, .Cross,  .Cross
                    ]
                    
                    expect(ai.isDraw(board)).to(beTruthy())
                }
                
                it("isGameOver") {
                    for var i = 0; i < ai.wins.count; i++ {
                        
                        let indices = ai.wins[i]
                        var board: [SquareType] = [SquareType](count: GameBoardSize, repeatedValue: .Empty)
                        let square: SquareType = (i % 2 == 0) ? .Cross : .Circle
                        for index in indices {
                            board[index] = square
                        }
                        
                        expect(ai.isGameOver(board)).to(beTruthy())
                    }
                    
                    let board: [SquareType] = [
                        .Circle, .Circle, .Cross,
                        .Cross,  .Cross,  .Circle,
                        .Circle, .Cross,  .Cross
                    ]
                    
                    expect(ai.isGameOver(board)).to(beTruthy())
                }
            }
            
            describe("Game Score") {
                
                it("Zero Game") {
                    let board: [SquareType] = [
                        .Empty, .Empty, .Empty,
                        .Empty, .Empty, .Empty,
                        .Empty, .Empty, .Empty
                    ]
                    
                    let score = ai.gameScore(board)
                    expect(score).to(equal(0))
                }
                
                it("Win Game") {
                    
                    for indices in ai.wins {
                        var board: [SquareType] = [SquareType](count: GameBoardSize, repeatedValue: .Empty)
                        for index in indices {
                            board[index] = .Cross
                        }
                        
                        let score = ai.gameScore(board)
                        expect(score).to(equal(AIEngine.GameScore.Win.rawValue))
                    }
                }
                
                it("Lose Game") {
                    
                    for indices in ai.wins {
                        var board: [SquareType] = [SquareType](count: GameBoardSize, repeatedValue: .Empty)
                        for index in indices {
                            board[index] = .Circle
                        }
                        
                        let score = ai.gameScore(board)
                         expect(score).to(equal(AIEngine.GameScore.Lose.rawValue))
                    }
                }
            }
            
            describe("minimax") {
                it("max value should be 10") {
                    var board:[SquareType] = [
                        .Circle,    .Empty,     .Cross,
                        .Cross,     .Empty,     .Empty,
                        .Cross,     .Circle,    .Circle
                    ]
                    
                    let value = ai.maxValue(board, depth: 4)
                    expect(value).to(equal(AIEngine.GameScore.Win.rawValue))
                }
                
                it("min value should be -10") {
                    var board:[SquareType] = [
                        .Circle,    .Cross,     .Cross,
                        .Cross,     .Empty,     .Empty,
                        .Cross,     .Circle,    .Circle
                    ]
                    
                    var value = ai.minValue(board, depth: 4)
                    expect(value).to(equal(-10))
                    
                    board = [
                        .Circle,    .Empty,     .Cross,
                        .Cross,     .Empty,     .Cross,
                        .Cross,     .Circle,    .Circle
                    ]
                    
                    value = ai.minValue(board, depth: 4)
                    expect(value).to(equal(-10))
                }
                
                it("best move should be index 4") {
                    var board:[SquareType] = [
                        .Circle,    .Empty,     .Cross,
                        .Cross,     .Empty,     .Empty,
                        .Cross,     .Circle,    .Circle
                    ]
                    
                    var index = ai.minimax(board, side: AIEngine.PlayerSide.X, depth: 4)
                    expect(index).to(equal(4))

                }
            }
        }
    }
}
