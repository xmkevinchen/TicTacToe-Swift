//
//  GameboardView.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import UIKit

protocol GameBoardDataSource : NSObjectProtocol {
    func numberOfSquareInBoardView(boardView: GameBoardView) -> Int
    func boardView(boardView: GameBoardView, squareTypeAtIndex: Int) -> GameSquareType
}

protocol GameBoardDelegate : NSObjectProtocol {
    func boardView(boardView: GameBoardView, canPressSquareAtIndex: Int) -> Bool
    func boardView(boardView: GameBoardView, didPressSquareAtIndex: Int)
}

class GameBoardView: UIView {
    
    var dataSource: GameBoardDataSource?
    var delegate: GameBoardDelegate?

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func reloadData() {
        
    }

}

