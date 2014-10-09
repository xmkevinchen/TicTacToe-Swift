//
//  AIEngine.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Foundation

/**
 *  AI engine for computer
 *  AI algorithm comes from the Minimax algorithm
 */
class AIEngine {
    
    private let INFINITY = 100
    private let DOUBLE_CONNECTED = 50
    private let INPROGRESS = 1

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
        return game.moves.count == GameBoardSize
    }
    
    func nextMove() -> Int {
        let index = random() % 9
        if game.board.matrix[index] != .Empty {
            return nextMove()
        } else {
            return index
        }

    }
    
    private func gameState() -> Int {
        return 0
    }
    
    private func minimax() -> Int {
        return 0
    }
    
    private func max() -> Int {
        return 0
    }
    
    private func min() -> Int {
        return 0
    }
    
}