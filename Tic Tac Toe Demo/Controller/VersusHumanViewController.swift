//
//  VersusHumanViewController.swift
//  Tic Tac Toe Demo
//
//  Created by Jihun Kang on 10/20/16.
//  Copyright © 2016 jkang. All rights reserved.
//

import UIKit

class VersusHumanViewController: UIViewController {

    var game = TicTacToe()
    var player1:Player!
    var player2:Player!
    var currentPlayer: Player!
    
    @IBOutlet var buttonsArray: [UIButton]!
    
    @IBOutlet weak var announcement: UILabel!
    
    @IBAction func restartPressed(_ sender: UIButton) {
        for button in buttonsArray {
            button.isEnabled = true
            button.setTitle("\" \"", for: UIControlState())
        }
        game.turn = 1
        game.board = [String](repeating: " ", count: 9)
        gameStatusUpdate()
    }
    
    @IBAction func positionPressed(_ sender: UIButton) {
        currentPlayer = whoIsTheCurrentPlayer()!
        
        if game.board[sender.tag] == " " {
            game.board[sender.tag] = currentPlayer.letter
            sender.setTitle(currentPlayer.letter, for: UIControlState())
            game.turn += 1
        }
        gameStatusUpdate()
        
    }
    
    func whoIsTheCurrentPlayer() -> Player? {
        var player: Player?
        if game.turn % 2 == 1 {
            player = player1
        } else {
            player = player2
        }
        return player
    }
    
    func disableButtons() { // if the game is over, the game should "freeze"
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
        
        if let player1Letter = UserDefaults.standard.value(forKey: "player1Letter") as? String {
            if player1Letter == "O" {
                player1 = Player(letter: .Nought, name: .Player1)
                player2 = Player(letter: .Cross, name: .Player2)
            } else if player1Letter == "X" {
                player1 = Player(letter: .Cross, name: .Player1)
                player2 = Player(letter: .Nought, name: .Player2)
            }
        } else {
            player1 = Player(letter: .Nought, name: .Player1)
            player2 = Player(letter: .Cross, name: .Player2)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
