//
//  ViewController.swift
//  DiceGame
//
//  Created by Yaqi Wang on 9/17/20.
//  Copyright © 2020 Yaqi Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DiceOne: UIImageView!
    
    @IBOutlet weak var DiceTwo: UIImageView!
    @IBOutlet weak var lblScore: UILabel!
    var dice1Value: Int = -1;
    var dice2Value: Int = -1;
    
    var totalScore = 0;
    let imageNames = ["One", "Two", "Three", "Four", "Five", "Six"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func rollDices() {
        dice1Value = Int.random(in: 0..<6);
        dice2Value = Int.random(in: 0..<6);
        
        DiceOne.image = UIImage(named: imageNames[dice1Value]);
        DiceTwo.image = UIImage(named: imageNames[dice2Value]);
    }

    @IBAction func resetAction(_ sender: UIButton) {
        //rollDices();
        totalScore = 0;
    }
    
    @IBAction func lessThanSeven(_ sender: UIButton) {
        rollDices();
        if dice1Value + dice2Value < 7 {
            totalScore += 1;
        }
        updateScore();
    }
    
    @IBAction func equalToSeven(_ sender: UIButton) {
        rollDices();
        if dice1Value + dice2Value == 7 {
            totalScore += 7;
        }
        updateScore();
    }
    
    @IBAction func greaterThanSeven(_ sender: UIButton) {
        rollDices();
        if dice1Value + dice2Value > 7 {
            totalScore += 1;
        }
        updateScore();
    }
    
    func updateScore() {
        lblScore.text = "Your Score = \(totalScore)";
    }
}

