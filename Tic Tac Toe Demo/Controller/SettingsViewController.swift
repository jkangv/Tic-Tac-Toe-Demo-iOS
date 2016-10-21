//
//  SettingsViewController.swift
//  Tic Tac Toe Demo
//
//  Created by Jihun Kang on 10/20/16.
//  Copyright © 2016 jkang. All rights reserved.
//

/*
 Settings are stored and saved.
 */

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var player1LetterChooser: UISegmentedControl!
    @IBOutlet weak var player2LetterChooser: UISegmentedControl!
    @IBOutlet weak var humanTurnChooser: UISegmentedControl!
    @IBOutlet weak var humanLetterChooser: UISegmentedControl!
    
    @IBAction func player1LetterSwitched(_ sender: AnyObject) {
        if player1LetterChooser.selectedSegmentIndex == 0 {
            player2LetterChooser.selectedSegmentIndex = 1
            UserDefaults.standard.setValue("O", forKey: "player1Letter")
            UserDefaults.standard.synchronize()
        } else if player1LetterChooser.selectedSegmentIndex == 1 {
            player2LetterChooser.selectedSegmentIndex = 0
            UserDefaults.standard.setValue("X", forKey: "player1Letter")
            UserDefaults.standard.synchronize()
        }
    }
    
    @IBAction func humanTurnSwitched(_ sender: AnyObject) {
        if humanTurnChooser.selectedSegmentIndex == 0 {
            UserDefaults.standard.setValue("first", forKey: "humanTurn")
            UserDefaults.standard.synchronize()
        } else if humanTurnChooser.selectedSegmentIndex == 1 {
            UserDefaults.standard.setValue("second", forKey: "humanTurn")
            UserDefaults.standard.synchronize()
        }
    }
    
    @IBAction func humanLetterSwitched(_ sender: AnyObject) {
        if humanLetterChooser.selectedSegmentIndex == 0 {
            UserDefaults.standard.setValue("O", forKey: "humanLetter")
            UserDefaults.standard.synchronize()
        } else if humanLetterChooser.selectedSegmentIndex == 1 {
            UserDefaults.standard.setValue("X", forKey: "humanLetter")
            UserDefaults.standard.synchronize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let player1Letter = UserDefaults.standard.value(forKey: "player1Letter") as? String {
            if player1Letter == "O" {
                player1LetterChooser.selectedSegmentIndex = 0
                player2LetterChooser.selectedSegmentIndex = 1
            } else if player1Letter == "X" {
                player1LetterChooser.selectedSegmentIndex = 1
                player2LetterChooser.selectedSegmentIndex = 0
            }
        }
        if let humanTurn = UserDefaults.standard.value(forKey: "humanTurn") as? String {
            if humanTurn == "first" {
                humanTurnChooser.selectedSegmentIndex = 0
            } else if humanTurn == "second" {
                humanTurnChooser.selectedSegmentIndex = 1
            }
        }
        if let humanLetter = UserDefaults.standard.value(forKey: "humanLetter") as? String {
            if humanLetter == "O" {
                humanLetterChooser.selectedSegmentIndex = 0
            } else if humanLetter == "X" {
                humanLetterChooser.selectedSegmentIndex = 1
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
