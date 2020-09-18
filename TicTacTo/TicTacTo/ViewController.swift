//
//  ViewController.swift
//  TicTacTo
//
//  Created by Yaqi Wang on 9/17/20.
//  Copyright © 2020 Yaqi Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //outlets for buttons
    @IBOutlet weak var one: UIButton!
    
    @IBOutlet weak var two: UIButton!
    
    @IBOutlet weak var three: UIButton!
    
    @IBOutlet weak var four: UIButton!
    
    @IBOutlet weak var five: UIButton!
    
    @IBOutlet weak var six: UIButton!
    
    @IBOutlet weak var seven: UIButton!
    
    @IBOutlet weak var eight: UIButton!
    
    @IBOutlet weak var nine: UIButton!
    
    //outlet for labels
    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblTurn: UILabel!
    var arrButtons: [UIButton]?
    var turn = true;
    var buttonValue = [-1, -1, -1, -1, -1, -1, -1, -1, -1];
    
    let winningCombinations = [
                                [1, 2, 3],
                                [4, 5, 6],
                                [7, 8, 9],
                                [1, 4 ,7],
                                [2, 5, 8],
                                [3, 6, 9],
                                [1, 5, 9],
                                [3, 5, 7]
                              ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize();
    }
    
    func initialize() {
        arrButtons = [one, two, three, four, five, six, seven, eight, nine];
        
        for button in arrButtons! {
            button.setTitle("", for: .normal);
        }
        

    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        let id = sender.tag;
        if buttonValue[id - 1] != -1 {
            return;
        }
        guard let arrButtons = arrButtons else {return}

        if turn == true {
            arrButtons[id - 1].setTitle("X", for: .normal);
            lblTurn.text = "0's turn";
            buttonValue[id - 1] = 0;
        } else {
            arrButtons[id - 1].setTitle("0", for: .normal);
            lblTurn.text = "X's turn";
            buttonValue[id - 1] = 1;
        }
        for combination in winningCombinations {
            if (buttonValue[combination[0] - 1] == buttonValue[combination[1] - 1] &&
            buttonValue[combination[1] - 1] == buttonValue[combination[2] - 1] &&
                buttonValue[combination[0] - 1] != -1) {
                if turn == true {
                    lblResult.text = "X won";
                } else {
                    lblResult.text = "0 won";
                }
            }
        }
        turn = !turn;
        
    }
    
    
}

