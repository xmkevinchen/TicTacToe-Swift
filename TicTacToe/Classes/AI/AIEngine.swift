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
    
    enum PlayerSide {
        case X, O
    }
    
    enum GameScore: Int {
        case Zero = 0, Win = 10, Lose = -10
    }

    private let RecursiveDepth = 2
    
    let wins = [
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
        let board = game.board
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
        return game.moves.count == GameBoardSize
    }
    
    
    func isDraw(board: [SquareType]) -> Bool {
        var isFull = true
        for square in board {
            if .Empty == square {
                isFull = false
                break
            }
        }
        
        return isFull && !isWin()
    }
    
    func isWin(board: [SquareType]) -> Bool {
        var win = false
        for indecies in wins {
            if board[indecies[0]] == .Empty {
                continue
            }
            
            var square = board[indecies[0]]
            if board[indecies[0]] == board[indecies[1]] && board[indecies[1]] == board[indecies[2]] {
                win = true
                break
            }
        }
        
        return win
    }
    
    func isGameOver(board: [SquareType]) -> Bool {
        return isWin(board) || isDraw(board)
    }
    
    func gameScore(board: [SquareType]) -> Int {
        var score: Int = 0
        for indecies in wins {
            if board[indecies[0]] == .Empty {
                continue
            }
            
            var square = board[indecies[0]]
            if board[indecies[0]] == board[indecies[1]] && board[indecies[1]] == board[indecies[2]] {
                score = (square == .Cross) ? GameScore.Win.rawValue : GameScore.Lose.rawValue
                break
            }
        }
        
        return score
    }
    
    /**
     ALPHA-BETA Pruning
    
        ALPHA-BETA cutoff is a method for reducing the number of nodes explored in the Minimax strategy. For the nodes it explores it computes, in addition to the score, an alpha value and a beta value.
    
        ALPHA value of a node
            It is a value never greater than the true score of this node.
            Initially it is the score of that node, if the node is a leaf, otherwise it is -infinity.
            Then at a MAX node it is set to the largest of the scores of its successors explored up to now, and at a MIN node to the alpha value of its predecessor.
    
        BETA value of a node
            It is a value never smaller than the true score of this node. Initially it is the score of that node, if the node is a leaf, otherwise it is +infinity.
            Then at a MIN node it is set to the smallest of the scores of its successors explored up to now, and at a MAX node to the beta value of its predecessor.
    
        It Is Guaranteed That:
    
            The score of a node will always be no less than the alpha value and no greater than the beta value of that node.
            As the algorithm evolves, the alpha and beta values of a node may change, but the alpha value will never decrease, and the beta value will never increase.
            When a node is visited last, its score is set to the alpha value of that node, if it is a MAX node, otherwise it is set to the beta value.
     */
    
    func maxValue(inout board: [SquareType], depth: Int, alpha: Int, beta:Int) -> Int {
       
        var score = gameScore(board)
        if isGameOver(board) || depth == 0 || alpha >= beta {
            printBoard(board)
            println("maxValue = \(score)")
            return score
        }
        
        var bestValue = Int.min
        for i in 0..<GameBoardSize {
            if board[i] == .Empty {
                board[i] = .Cross
                var value = minValue(&board, depth: depth - 1, alpha: max(bestValue, alpha), beta: beta)
                bestValue = max(value, bestValue)
                board[i] = .Empty
            }
        }
        
        return bestValue
    }
    
    func minValue(inout board: [SquareType], depth: Int, alpha: Int, beta: Int) -> Int {
        
        var score = gameScore(board)
        if isGameOver(board) || depth == 0 || alpha >= beta {
            printBoard(board)
            println("minValue = \(score)")
            return score
        }
        
        var bestValue = Int.max
        for i in 0..<GameBoardSize {
            if board[i] == .Empty {
                board[i] = .Circle
                var value = maxValue(&board, depth: depth - 1, alpha: alpha, beta: min(bestValue, beta))
                bestValue = min(value, bestValue)
                board[i] = .Empty
            }
        }
        
        return bestValue
    }
    
    func minimax(inout board: [SquareType], side: PlayerSide, depth: Int) -> Int {
        var moves: [Int] = []
        if side == .X {
            var bestScore = Int.min
            for i in 0..<GameBoardSize {
                if board[i] == .Empty {
                    board[i] = .Cross
                    var score = minValue(&board, depth: depth, alpha: GameScore.Lose.rawValue, beta: GameScore.Win.rawValue)
                    if score > bestScore {
                        moves.removeAll(keepCapacity: false)
                        bestScore = score
                        moves.append(i)
                    } else if score == bestScore {
                        moves.append(i)
                    }
                    board[i] = .Empty
                }
            }
        } else {
            var bestScore = Int.max
            for i in 0..<GameBoardSize {
                if board[i] == .Empty {
                    board[i] = .Circle
                    var score = maxValue(&board, depth: depth, alpha: GameScore.Lose.rawValue, beta: GameScore.Win.rawValue)
                    if score < bestScore {
                        moves.removeAll(keepCapacity: false)
                        bestScore = score
                        moves.append(i)
                    } else if score == bestScore {
                        moves.append(i)
                    }
                    board[i] = .Empty
                }
            }

        }
        
//        println("moves = \(moves)")
        
        return moves.count > 0 ? moves[Int(arc4random()) % moves.count] : 0
    }
    
    func nextMove(closure: (Int) -> Void) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var index: Int!
            if self.game.moves.count <= 2 {
                // Help computer to chose best position for the first round
                // Center is the best, and then is corners
                if self.game.board[4] == .Empty {
                    index = 4
                } else {
                    index = [0, 3, 6, 8][Int(arc4random()) % 4]
                }
            } else {
                if self.game.moves.count % 2 == 0 {
                    index = self.minimax(&self.game.board, side: .X, depth: self.RecursiveDepth)
                } else {
                    index = self.minimax(&self.game.board, side: .O, depth: self.RecursiveDepth)
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                closure(index)
            })
        });
        
    }
    
    func printBoard(board:[SquareType]) {
        println("==========")
        for var i = 0; i < GameBoardSize; i++ {
            if i != 0 && i % 3 == 0 {
                println()
            }
            var square: SquareType = board[i]
            print("\(square.rawValue) ")
            
        }
        println()
        println("==========")
    }
    
    
}