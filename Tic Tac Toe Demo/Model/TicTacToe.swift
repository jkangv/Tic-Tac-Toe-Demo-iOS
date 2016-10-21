//
//  TicTacToe.swift
//  Tic Tac Toe Demo
//
//  Created by Jihun Kang on 10/20/16.
//  Copyright © 2016 jkang. All rights reserved.
//

import Foundation
import GameplayKit

class TicTacToe {
    var board = [String](repeating: " ", count: 9) // In this demo, " " means an empty spot of the board.
    var tempBoard: [String]!
    var turn = 1
    var noughtForks = 0
    var crossForks = 0
    var human: Player?
    var AI: Player?
    
    let cornerPositions = [0, 2, 6, 8]
    let sidePositions = [1, 3, 5, 7]
    
    let winCombinations = [[0,1,2], [0,4,8], [0,3,6], [1,4,7], [2,5,8], [3,4,5], [6,7,8], [2,4,6]]
    
    
    func thereIsAWinner(_ board: [String]) -> Bool {
        for combination in winCombinations {
            if board[combination[0]] != " " && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] { // three in a row
                return true
            }
        }
        return false
    }
    
    func isPositionEmpty(_ position: Int) -> Bool {
        if self.board[position] == " " {
            return true
        } else {
            return false
        }
    }
    
    func isWinningMove(_ position: Int, player: Player!, currentBoard: [String]) -> Bool {
        tempBoard = currentBoard // use a temporary board to see if the move wins them the game.
        if tempBoard[position] == " " {
            tempBoard[position] = player.letter // put in the theoretical move into the tempBoard if it is empty.
            if thereIsAWinner(tempBoard) {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func isCenterEmpty() -> Bool {
        if self.board[4] == " " {
            return true
        } else {
            return false
        }
    }
    
    func emptyCornerPositions() -> [Int] {
        var positions: [Int] = []
        var i = 0
        while (i <= 8) {
            if i == 4 {
                i += 2
                continue
            }
            if self.board[i] == " " {
                positions.append(i)
            }
            i += 2
        }
        return positions
    }
    
    func emptySidePositions() -> [Int] {
        var positions: [Int] = []
        var i = 1
        while (i <= 7) {
            if self.board[i] == " " {
                positions.append(i)
            }
            i += 2
        }
        return positions
    }
    
    func isBoardEmpty() -> Bool {
        for i in 0...8 {
            if board[i] != " " {
                return false
            }
        }
        return true
    }
    
    func oppositeCornerPosition() -> Int? {
        if self.board[0] == human?.letter && self.board[8] == " " {
            return 8
        } else if self.board[2] == human?.letter && self.board[6] == " " {
            return 6
        } else if self.board[6] == human?.letter && self.board[2] == " " {
            return 2
        } else if self.board[8] == human?.letter && self.board[0] == " " {
            return 0
        }
        
        return nil
    }
    
    func howManyWinningMoves(_ player: Player!, temporaryBoard: [String]) -> Int {
        var moves = 0
        var anotherTempBoard: [String]!
        for position in 0...8 {
            anotherTempBoard = temporaryBoard
            if anotherTempBoard[position] != " " { continue }
            anotherTempBoard[position] = player.letter
            if thereIsAWinner(anotherTempBoard) {
                moves += 1
            } else {
                continue
            }
        }
        return moves
    }
    
    func isAForkMove(_ position: Int, player: Player!, currentBoard: [String]) -> Bool {
        tempBoard = currentBoard
        if tempBoard[position] != " " {
            return false
        }
        tempBoard[position] = player.letter
        if howManyWinningMoves(player, temporaryBoard: tempBoard) >= 2 {
            return true
        } else {
            return false
        }
    }
    
    func possibleForkBlocks() -> [Int] {
        var positions: [Int] = []
        var yetAnotherTempBoard: [String]
        if self.turn > 3 {
            for position in 0...8 {
                yetAnotherTempBoard = self.board
                if yetAnotherTempBoard[position] != " " { continue }
                yetAnotherTempBoard[position] = (AI?.letter)!
                for humanPosition in 0...8 {
                    if yetAnotherTempBoard[humanPosition] != " " { continue }
                    
                    if isWinningMove(humanPosition, player: AI, currentBoard: yetAnotherTempBoard) {
                        yetAnotherTempBoard[humanPosition] = (human?.letter)!
                        if howManyWinningMoves(human, temporaryBoard: yetAnotherTempBoard) < 2 {
                            positions.append(position)
                        }
                    }
                    
                }
            }
        }
        return positions
    }
    
    func randomizeMove(_ possiblePositions: [Int]) -> Int { // make the game slightly more fun.
        return possiblePositions[GKRandomSource.sharedRandom().nextInt(upperBound: possiblePositions.count)]
    }
    
    func randomMove() -> Int { // put a piece anywhere in the board.
        var random: Int
        repeat {
            random = GKRandomSource.sharedRandom().nextInt(upperBound: 9)
            if self.turn == 10 {
                break
            }
            if self.isPositionEmpty(random) {
                return random
            }
        } while !self.isPositionEmpty(random)
        return random
    }
    
    func easyAIMove() -> Int {
        for position in 0...8 {
            if !isPositionEmpty(position) { continue }
            if isWinningMove(position, player: AI, currentBoard: self.board) {
                return position
            }
        }
        return randomMove()
    }
    
    func mediumAIMove() -> Int {
        var choices: [String: [Int]] = ["ai win moves":[], "block human win": [], "ai fork moves": []]
        for position in 0...8 {
            if !isPositionEmpty(position) { continue }
            if isWinningMove(position, player: AI, currentBoard: self.board) {
                choices["ai win moves"]?.append(position)
            }
            if isWinningMove(position, player: human, currentBoard: self.board) {
                choices["block human win"]?.append(position)
            }
            if isAForkMove(position, player: AI, currentBoard: self.board) {
                choices["ai fork moves"]?.append(position)
            }
        }
        if !choices["ai win moves"]!.isEmpty {
            return randomizeMove(choices["ai win moves"]!)
        } else if !choices["block human win"]!.isEmpty {
            return randomizeMove(choices["block human win"]!)
        } else if !choices["ai fork moves"]!.isEmpty {
            return randomizeMove(choices["ai fork moves"]!)
        }
        return randomMove()
    }
    
    func impossibleAIMove() -> Int {
        if isBoardEmpty() { // this is when impossible ai goes first.
            return randomizeMove([0,2,4,6,8])
        }
        var choices: [String: [Int]] = ["ai win moves": [], "block human win": [], "ai fork moves": [], "block human forks": [], "center move": [], "opposite corner of human piece": [], "empty corner": [], "empty side": []]
        for position in 0...8 {
            if !isPositionEmpty(position) { continue }
            if isWinningMove(position, player: AI, currentBoard: self.board) {
                choices["ai win moves"]?.append(position)
            }
            if isWinningMove(position, player: human, currentBoard: self.board) {
                choices["block human win"]?.append(position)
            }
            if isAForkMove(position, player: AI, currentBoard: self.board) {
                choices["ai fork moves"]?.append(position)
            }
        }
        
        choices["block human forks"] = possibleForkBlocks()
        if isCenterEmpty() {
            choices["center move"]?.append(4)
        }
        
        if let oppositeCorner = oppositeCornerPosition() {
            choices["opposite corner of human piece"]?.append(oppositeCorner)
        }
        
        choices["empty corner"] = emptyCornerPositions()
        choices["empty side"] = emptySidePositions()
        
        if !choices["ai win moves"]!.isEmpty { // these moves are in order of importance (first being most important)
            return randomizeMove(choices["ai win moves"]!)
        } else if !choices["block human win"]!.isEmpty {
            return randomizeMove(choices["block human win"]!)
        } else if !choices["ai fork moves"]!.isEmpty {
            return randomizeMove(choices["ai fork moves"]!)
        } else if !choices["block human forks"]!.isEmpty {
            return randomizeMove(choices["block human forks"]!)
        } else if !choices["center move"]!.isEmpty {
            return randomizeMove(choices["center move"]!)
        } else if !choices["opposite corner of human piece"]!.isEmpty {
            return randomizeMove(choices["opposite corner of human piece"]!)
        } else if !choices["empty corner"]!.isEmpty {
            return randomizeMove(choices["empty corner"]!)
        } else if !choices["empty side"]!.isEmpty {
            return randomizeMove(choices["empty side"]!)
        }

        return randomMove() // if all else fails.
    }
}
