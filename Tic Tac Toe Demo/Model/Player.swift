//
//  Player.swift
//  Tic Tac Toe Demo
//
//  Created by Jihun Kang on 10/20/16.
//  Copyright © 2016 jkang. All rights reserved.
//

import Foundation

class Player {
    
    enum Letter: String {
        case Nought = "O"
        case Cross = "X"
    }
    
    enum PlayerName: String {
        case Player1 = "player 1"
        case Player2 = "player 2"
        case AI = "AI"
    }
    
    fileprivate var _letter: Letter!
    fileprivate var _name: PlayerName!
    
    var letter: String {
        get {
            return _letter.rawValue
        } set {
            if newValue == Letter.Nought.rawValue {
                _letter = .Nought
            } else if newValue == Letter.Cross.rawValue {
                _letter = .Cross
            }
        }
    }
    
    var name: String {
        get {
            return _name.rawValue
        } set {
            if newValue == PlayerName.Player1.rawValue {
                _name = .Player1
            } else if newValue == PlayerName.Player2.rawValue {
                _name = .Player2
            } else if newValue == PlayerName.AI.rawValue {
                _name = .AI
            }
        }
    }
    
    init(letter: Letter, name: PlayerName) {
        self._letter = letter
        self._name = name
    }
    
}
