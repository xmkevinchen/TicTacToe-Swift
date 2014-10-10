//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/6/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GameBoardDataSource, GameBoardDelegate, GameDelegate {
    
    
    @IBOutlet weak var boardView: GameBoardView!
    var gameController: GameController!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tic Tac Toe"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "gameReset:")
        
        gameController = GameController()
        gameController.delegate = self
        
        boardView.delegate = self
        boardView.dataSource = self
        
        gameController.reset()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameReset(sender: AnyObject!) {
        
        switch gameController.status {
        case .Playing:
            var alert = UIAlertView(title: "New Game?", message: "", delegate: nil, cancelButtonTitle: "Cancel")
            alert.addButtonWithTitle("Confirm")
            alert.rac_buttonClickedSignal().subscribeNext { buttonIndex in
                if buttonIndex as Int == 1 {
                    self.gameController.reset()
                    self.boardView.reloadData()
                }
            }
            alert.show()
            
        case .Over:
            self.gameController.reset()
            self.boardView.reloadData()
            
        case .Start:
            self.gameController.reset()

        default:
            break
            
        }
        
    }
    
    
    // MARK: GameBoardView
    
    func boardView(boardView: GameBoardView, squareTypeAtIndex: Int) -> GameSquareType {
        return gameController.squareType(squareTypeAtIndex)
    }
    
    func boardView(boardView: GameBoardView, canPressSquareAtIndex: Int) -> Bool {
        return GameSquareType.Empty == gameController.squareType(canPressSquareAtIndex)
            && GameStatus.Over != gameController.status
    }
    
    func boardView(boardView: GameBoardView, didPressSquareAtIndex: Int) {
        gameController.moveAt(didPressSquareAtIndex)
        
    }
    
    // MARK: GameDelegate
    func gameController(gameController: GameController, didMoveAtIndex: Int) {
        boardView.reloadCellAt(didMoveAtIndex)
    }
    
    func gameControllerPlayerXDidWin(gameController: GameController) {
        UIAlertView(title: "Player X Win", message: "Congratulation", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    func gameControllerPlayerODidWin(gameController: GameController) {
        UIAlertView(title: "Player O Win", message: "Congratulation", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    func gameControllerDidDraw(gameController: GameController) {
        UIAlertView(title: "Draw", message: "One more time...", delegate: nil, cancelButtonTitle: "OK").show()
    }


}

