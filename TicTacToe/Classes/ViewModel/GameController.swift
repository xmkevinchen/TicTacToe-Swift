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
    var ai: AIEngine
    
    var vsComputer: Bool = true
    var computerFirst: Bool = false
    
    private var wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                        [0, 3, 6], [1, 4, 7], [2, 5, 8],
                        [0, 4, 8], [2, 4, 6]
                        ]
    
    init() {
        self.game = Game(mode: .Computer)
        self.status = .Start
        self.ai = AIEngine(game: self.game)
        
    }
    
    func squareType(index: Int) -> SquareType {
        return game.board[index]
    }
    
    func moveAt(index: Int) {
        var type = SquareType.Empty
        if .Start == status {
            status = .Playing
        }
        var player = currentPlayer()
        if player === game.playerX {
            type = .Cross
        } else {
            type = .Circle
        }
        game.board[index] = type
        player.moves.append(index)
        game.moves.append(index)
        
        delegate.gameController(self, didMoveAtIndex: index)
        
        if ai.isWin() {
            if player === game.playerX {
                delegate.gameControllerPlayerXDidWin(self)
            } else {
                delegate.gameControllerPlayerODidWin(self)
            }
            
            status = .Over
            return
        }
        
        if ai.isDraw() {
            delegate.gameControllerDidDraw(self)
            status = .Over
            return
        }
        
        player = currentPlayer()
        
        if player.mode == .Computer {
            ai.nextMove() { index in
                self.moveAt(index)
            }
            
        }
    }
    
    
    func reset() {
        status = .Start
        game.reset()
        
        if vsComputer {
            game.mode = .Computer
            if computerFirst {
                game.playerX.mode = .Computer
                game.playerO.mode = .Human
            } else {
                game.playerX.mode = .Human
                game.playerO.mode = .Computer
            }
        } else {
            game.mode = .Player
            game.playerX.mode = .Human
            game.playerO.mode = .Human
        }
        
        if game.playerX.mode == .Computer {
            ai.nextMove() { index in
                self.moveAt(index)

            }

        }
    }
            
    private func currentPlayer() -> Player {
        if game.moves.count % 2 == 0 {
            return game.playerX
        } else {
            return game.playerO
        }
    }
    
}