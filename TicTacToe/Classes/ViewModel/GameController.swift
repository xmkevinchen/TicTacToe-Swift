//
//  GameController.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/8/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import Foundation

protocol GameDelegate {
    func gameController(gameController: GameController, didMoveAtIndex: Int)
    func gameControllerPlayerXDidWin(gameController: GameController)
    func gameControllerPlayerODidWin(gameController: GameController)
    func gameControllerDidDraw(gameController: GameController)
}

enum GameStatus {
    case Start, Playing, Over
}

class GameController {
    
    var game: Game!
    var delegate: GameDelegate!
    var status: GameStatus
    
    private var wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                        [0, 3, 6], [1, 4, 7], [2, 5, 8],
                        [0, 4, 8], [2, 4, 6]
                        ]
    
    init() {
        self.game = Game(mode: .Player)
        self.status = .Start
        
    }
    
    func squareType(index: Int) -> GameSquareType {
        return game.board.matrix[index]
    }
    
    func moveAt(index: Int) {
        var type = GameSquareType.Empty
        if .Start == status {
            status = .Playing
        }
        var player = whoseTurn()
        if player === game.playerX {
            type = .Cross
        } else {
            type = .Circle
        }
        game.board.matrix[index] = type
        player.moves.append(index)
        game.moves.append(index)
        
        delegate.gameController(self, didMoveAtIndex: index)
        
        if isWinner(player) {
            if player === game.playerX {
                delegate.gameControllerPlayerXDidWin(self)
            } else {
                delegate.gameControllerPlayerODidWin(self)
            }
            
            status = .Over
            return
        }
        
        if game.moves.count == GameBoardSize {
            delegate.gameControllerDidDraw(self)
            status = .Over
        }
    }
    
    func reset() {
        status = .Start
        game.reset()
    }
    
    private func isWinner(player: Player) -> Bool {
        var type = GameSquareType.Empty
        if player === game.playerX {
            type = .Cross
        } else {
            type = .Circle
        }
        
        var win = false
        
        for var i = 0; i < wins.count; i++ {
            var indecies = wins[i]
            if game.board.matrix[indecies[0]] != type {
                continue
            }
            
            if game.board.matrix[indecies[0]] == game.board.matrix[indecies[1]]
                && game.board.matrix[indecies[1]] == game.board.matrix[indecies[2]] {
                win = true;
                break;
            }
        }
        
        return win
    }
    
    private func whoseTurn() -> Player {
        if game.playerX.moves.count <= game.playerO.moves.count {
            return game.playerX
        } else {
            return game.playerO
        }
    }
}