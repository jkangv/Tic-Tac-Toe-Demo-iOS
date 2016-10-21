//
//  VersusAIViewController.swift
//  Tic Tac Toe Demo
//
//  Created by Jihun Kang on 10/20/16.
//  Copyright © 2016 jkang. All rights reserved.
//

import UIKit

class VersusAIViewController: UIViewController {

    var game = TicTacToe()
    var human: Player!
    var AI: Player!
    var currentPlayer: Player!
    var difficulty: String!
    
    @IBOutlet var buttonsArray: [UIButton]!
    
    @IBOutlet weak var announcement: UILabel!
    
    @IBAction func restartPressed(_ sender: UIButton) {
        for button in buttonsArray {
            button.isEnabled = true
            button.setTitle("\" \"", for: UIControlState())
        }
        game.turn = 1
        game.board = [String](repeating: " ", count: 9)
        if whoIsTheCurrentPlayer() === AI {
            AIMove()
        }
        gameStatusUpdate()
    }
    
    @IBAction func positionPressed(_ sender: UIButton) {
        currentPlayer = whoIsTheCurrentPlayer()!
        
        if game.board[sender.tag] == " " && currentPlayer === human {
            game.board[sender.tag] = human.letter
            sender.setTitle(human.letter, for: UIControlState())
            game.turn += 1
            gameStatusUpdate()
            currentPlayer = AI
        }
        
        if currentPlayer === AI && !game.thereIsAWinner(game.board) {
            AIMove()
            gameStatusUpdate()
            
        }
        
    }
    
    func whoIsTheCurrentPlayer() -> Player? {
        var player: Player?
        if let humanTurn = UserDefaults.standard.value(forKey: "humanTurn") as? String {
            if humanTurn == "first" && game.turn % 2 == 1 {
                player = human
            } else if humanTurn == "first" && game.turn % 2 == 0 {
                player = AI
            } else if humanTurn == "second" && game.turn % 2 == 1 {
                player = AI
            } else if humanTurn == "second" && game.turn % 2 == 0 {
                player = human
            }
        }
        return player
    }
    
    func AIMove() {
        var move: Int!
        
        if difficulty == "impossible" {
            move = game.impossibleAIMove()
        } else if difficulty == "medium" {
            move = game.mediumAIMove()
        } else if difficulty == "easy" {
            move = game.easyAIMove()
        }

        for button in buttonsArray { // this is where the AI makes the move on the board.
            if button.tag == move && game.turn <= 9 {
                game.board[move] = AI.letter
                button.setTitle(AI.letter, for: UIControlState())
                break
            }
        }

        game.turn += 1
    }
    
    func disableButtons() { // when the game is over, the board should "freeze."
        for button in buttonsArray {
            button.isEnabled = false
        }
    }
    
    func gameStatusUpdate() {
        let tempPlayer = whoIsTheCurrentPlayer()!
        
        if game.turn >= 5 && game.thereIsAWinner(game.board) {
            announcement.text = "Winner is: \(currentPlayer.name)(\(currentPlayer.letter))"
            disableButtons()
        } else if !game.thereIsAWinner(game.board) && game.turn < 10 {
            announcement.text = "It is \(tempPlayer.name)(\(tempPlayer.letter))'s turn!"
        }
        if game.turn >= 10 && !game.thereIsAWinner(game.board) {
            announcement.text = "It's a draw!"
            disableButtons()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let humanLetter = UserDefaults.standard.value(forKey: "humanLetter") as? String {
            if humanLetter == "O" {
                human = Player(letter: .Nought, name: .Player1)
                AI = Player(letter: .Cross, name: .AI)
            } else if humanLetter == "X" {
                human = Player(letter: .Cross, name: .Player1)
                AI = Player(letter: .Nought, name: .AI)
            }
        } else {
            human = Player(letter: .Nought, name: .Player1)
            AI = Player(letter: .Cross, name: .AI)
        }
        
        game.human = human
        game.AI = AI
        
        currentPlayer = whoIsTheCurrentPlayer()!
        if currentPlayer === AI { // this is if the AI goes first.
            AIMove()
            gameStatusUpdate()
        } else {
            gameStatusUpdate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
