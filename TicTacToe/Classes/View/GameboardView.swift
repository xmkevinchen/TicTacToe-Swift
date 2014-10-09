//
//  GameboardView.swift
//  TicTacToe
//
//  Created by Kevin Chen on 10/7/14.
//  Copyright (c) 2014 Kevin Chen. All rights reserved.
//

import UIKit

protocol GameBoardDataSource : NSObjectProtocol {

//    func numberOfSquareInBoardView(boardView: GameBoardView) -> Int
    func boardView(boardView: GameBoardView, squareTypeAtIndex: Int) -> GameSquareType
}

protocol GameBoardDelegate : NSObjectProtocol {
    func boardView(boardView: GameBoardView, canPressSquareAtIndex: Int) -> Bool
    func boardView(boardView: GameBoardView, didPressSquareAtIndex: Int)
}

/**
 * 
Board index like below
 -------------------
 |     |     |     |
 |  0  |  1  |  2  |
 |     |     |     |
 -------------------
 |     |     |     |
 |  3  |  4  |  5  |
 |     |     |     |
 -------------------
 |     |     |     |
 |  6  |  7  |  8  |
 |     |     |     |
 -------------------
 */
class GameBoardView: UIView, UIGestureRecognizerDelegate {
    
    var dataSource: GameBoardDataSource?
    var delegate: GameBoardDelegate?
    var squares: [UIImageView]!
    var circleImage: UIImage!
    var crossImage: UIImage!
    
    private var tapGesture: UITapGestureRecognizer!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        println("frame = \(frame)")
        self.squares = [UIImageView]()
        
        
        var offsetx = frame.size.width / 3
        var offsety = frame.size.height / 3
        
        self.circleImage = FAKFontAwesome.circleOIconWithSize(offsetx * 0.6)
            .imageWithSize(CGSize(width: offsetx * 0.6, height: offsety * 0.6));
        self.crossImage = FAKFontAwesome.timesIconWithSize(offsetx * 0.75)
            .imageWithSize(CGSize(width: offsetx * 0.75, height: offsety * 0.75));
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: "tapAction:")
        self.tapGesture.delegate = self
        self.addGestureRecognizer(self.tapGesture)
        
    }
    
    override func awakeFromNib() {
        setUpBoardLines()
        setUpSquares()

    }
    
    func tapAction(gesture: UITapGestureRecognizer) {
        var point = gesture.locationInView(self)
//        println("point \(point) tapped");
//        println("cell[\(indexOfCell(point))] tapped");
        
        delegate!.boardView(self, didPressSquareAtIndex: indexOfCell(point))
        
    }
    
    private func indexOfCell(point:CGPoint) -> Int {
        var offsetx = frame.size.width / 3
        var offsety = frame.size.height / 3
        
        var x = Int(point.x / offsetx)
        var y = Int(point.y / offsety)
        
        return x + y * 3
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        var index = indexOfCell(gestureRecognizer.locationInView(self))
        return delegate!.boardView(self, canPressSquareAtIndex: index)
    }
        
    func reloadCellAt(index: Int) {
        var imageView = self.squares[index]
        var squareType = dataSource!.boardView(self, squareTypeAtIndex: index)
        switch squareType {
        case .Empty:
            imageView.image = nil
            
        case .Cross:
            imageView.image = self.crossImage
            
        case .Circle:
            imageView.image = self.circleImage
        }
    }
    
    func reloadData() {
        for var i = 0; i < 9; i++ {
            reloadCellAt(i)
        }
    }

    private func setUpSquares() {
        
        var offsetx = frame.size.width / 3
        var offsety = frame.size.height / 3
        
        for var i = 0; i < 9; i++ {
            var square = UIImageView(image: nil)
            let frame = CGRect(x: CGFloat(i % 3) * offsetx, y: CGFloat(i / 3) * offsety, width: offsetx, height: offsety)
            square.frame = frame
            square.contentMode = .Center
            self.squares.append(square)
            self.addSubview(square)
        }
        
    }
    
    private func setUpBoardLines() {
        // Draw the board lines
        var offsetx = frame.size.width / 3
        var offsety = frame.size.height / 3
        
        var hLine = UIView(frame: CGRect(x: 0, y: offsety, width: frame.size.width, height: 1))
        hLine.backgroundColor = UIColor.blackColor()
        self.addSubview(hLine)
        
        hLine = UIView(frame: CGRect(x: 0, y: offsety * 2, width: frame.size.width, height: 1))
        hLine.backgroundColor = UIColor.blackColor()
        self.addSubview(hLine)
        
        var vLine = UIView(frame: CGRect(x: offsetx, y: 0, width: 1, height: frame.size.height))
        vLine.backgroundColor = UIColor.blackColor()
        self.addSubview(vLine)
        
        vLine = UIView(frame: CGRect(x: offsetx * 2, y: 0, width: 1, height: frame.size.height))
        vLine.backgroundColor = UIColor.blackColor()
        self.addSubview(vLine)
        
    }

}

