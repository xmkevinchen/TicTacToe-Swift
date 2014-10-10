//
//  AIEngine.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Foundation

let INFINITY = 100

/**
 *  AI engine for computer
 *  AI algorithm comes from the Minimax algorithm
 */
class AIEngine {
    
    let WIN                 = INFINITY
    let LOSE                = -INFINITY
    let DOUBLE_CONNECTED    = INFINITY / 2
    let DRAW                = 0
    let INPROCESS           = 1
    
    private let wins = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    private let init_pos_values = [
        3, 2, 3,
        2, 4, 2,
        3, 2, 3
    ]
    
    var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func isWin() -> Bool {
        let board = game.board.matrix
        var result = false
        for indecies in wins {
            var square = board[indecies[0]]
            if square == .Empty {
                continue
            }
            
            if board[indecies[0]] == board[indecies[1]] && board[indecies[1]] == board[indecies[2]] {
                result = true
                break
            }
        }
        
        return result
    }
    
    
    func isDraw() -> Bool {
        return game.moves.count == GameBoardSize && !isWin()
    }
    
    func nextMove() -> Int {
        if game.moves.count == 0 {
            return 4
        } else if game.moves.count == 1 {
            if game.board.matrix[4] == .Empty {
                return 4
            } else {
                var corners = [0, 2, 6, 8]
                return corners[Int(arc4random() % 4)]
            }
        } else {
            if game.moves.count % 2 == 0 {
                return minimax(game.playerX, depth: 4)
            } else {
                return minimax(game.playerO, depth: 4)
            }
        }
    }
    
    private func minimax(player: Player, depth: Int) -> Int {
        var bestMoves = [Int](count: GameBoardSize, repeatedValue: 0)
        var index = 0
        var bestValue = 0
        if player === game.playerX {
            bestValue = INFINITY
            for var i = 0; i < GameBoardSize; i++ {
                if game.board.matrix[i] == .Empty {
                    game.board.matrix[i] = .Circle
                    var value = maxMove(depth, alpha: INFINITY, beta: -INFINITY)
                    if value < bestValue {
                        bestValue = value
                        index = 0
                        bestMoves[index] = i
                    } else if value == bestValue {
                        index++
                        bestMoves[index] = i
                    }
                    
                    game.board.matrix[i] = .Empty
                }
            }
        } else {
            bestValue = -INFINITY
            
            for var i = 0; i < GameBoardSize; i++ {
                if game.board.matrix[i] == .Empty {
                    game.board.matrix[i] = .Cross
                    var value = minMove(depth, alpha: -INFINITY, beta: INFINITY)
                    if value > bestValue {
                        bestValue = value
                        index = 0
                        bestMoves[index] = i
                    } else if value == bestValue {
                        index++
                        bestMoves[index] = i
                    }
                    
                    game.board.matrix[i] = .Empty
                }
            }
            
        }
        
        if index > 1 {
            index = Int(arc4random()) % index
        }
        
        return bestMoves[index]
    }
    
    /**
    Evaluate the value of current board
    
    :returns: evaluated value
    */
    private func evaluate() -> Int {
        let board = game.board.matrix
        
        var result = INPROCESS
        if isDraw() {
            result = DRAW
        }
        
        // check win or lose
        for indecies in wins {
            var square = board[indecies[0]]
            if square == .Empty {
                continue
            }
            
            var i = 1
            for ; i < indecies.count; i++ {
                if board[indecies[i]] != square {
                    break
                }
            }
            
            if i == indecies.count {
                result = (square == .Cross) ? WIN : LOSE
                break
            }
            
        }
        
        if result != WIN && result != LOSE && result != DRAW {
            // Find double connected
            var xFounds = 0
            var oFounds = 0
            for indecies in wins {
                var square = GameSquareType.Empty
                var hasEmpty = false
                var count = 0
                for index in indecies {
                    if board[index] == .Empty {
                        hasEmpty = true
                    } else {
                        if square == .Empty {
                            square = board[index]
                        }
                        
                        if board[index] == square {
                            count++
                        }
                    }
                }
                
                if hasEmpty && count > 1 {
                    if square == .Cross {
                        xFounds++
                    } else {
                        oFounds++
                    }
                }
            }
            
            if xFounds > 0 {
                result = DOUBLE_CONNECTED
            } else if oFounds > 0 {
                result = -DOUBLE_CONNECTED
            }
            
        }
        
        return result
    }
    
    private func maxMove(depth: Int, alpha: Int, beta: Int) -> Int {
        
        let value = evaluate()
        if value != INPROCESS || depth == 0 || beta <= alpha {
            return value
        }
        
        var bestScore = -INFINITY
        var board = game.board.matrix
        for var i = 0; i < GameBoardSize; i++ {
            if board[i] == .Empty {
                game.board.matrix[i] = .Cross
                var tmp = minMove(depth - 1, alpha: max(bestScore, alpha), beta: beta)
                bestScore = max(bestScore, tmp)
                game.board.matrix[i] = .Empty
            }
        }
        
        return bestScore
    }
    
    private func minMove(depth: Int, alpha: Int, beta:Int) -> Int {
        
        let value = evaluate()
        if value != INPROCESS {
            return value
        }
        
        var bestScore = INFINITY
        for var i = 0; i < GameBoardSize; i++ {
            if game.board.matrix[i] == .Empty {
                game.board.matrix[i] = .Circle
                var tmp = maxMove(depth - 1, alpha: alpha, beta: min(bestScore, beta))
                bestScore = min(bestScore, tmp)
                game.board.matrix[i] = .Empty
            }
        }
        
        return bestScore
    }
    
    private func printBoard() {
        let board = game.board.matrix
        for var i = 0; i < GameBoardSize; i++ {
            if i != 0 && i % 3 == 0 {
                println()
            }
            var square: GameSquareType = board[i]
            print("\(square.rawValue) ")
            
        }
        
        println()
    }
    
    
}