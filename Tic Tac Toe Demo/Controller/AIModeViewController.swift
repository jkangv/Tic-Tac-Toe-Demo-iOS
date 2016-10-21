//
//  AIModeViewController.swift
//  Tic Tac Toe Demo
//
//  Created by Jihun Kang on 10/20/16.
//  Copyright © 2016 jkang. All rights reserved.
//

import UIKit

class AIModeViewController: UIViewController {

    @IBAction func easyModePressed(_ sender: UIButton) {
        let string = "easy"
        performSegue(withIdentifier: "easy", sender: string)
    }
    
    @IBAction func mediumModePressed(_ sender: UIButton) {
        let string = "medium"
        performSegue(withIdentifier: "medium", sender: string)
    }
    
    @IBAction func impossibleModePressed(_ sender: UIButton) {
        let string = "impossible"
        performSegue(withIdentifier: "impossible", sender: string)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let versusAIVC = segue.destination as? VersusAIViewController {
            if let mode = sender as? String {
                versusAIVC.difficulty = mode // VersusAIViewController gets the mode as a string from this code.
            }
        }
    }
}
