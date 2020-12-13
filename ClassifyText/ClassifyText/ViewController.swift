//
//  ViewController.swift
//  ClassifyText
//
//  Created by Yaqi Wang on 12/13/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblSentiment: UILabel!
    @IBOutlet weak var txtFromUser: UITextField!
    
    let model = HappySadClassifier();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func analyzeSentiment(_ sender: Any) {
        if txtFromUser.text != "" {
            let text = txtFromUser.text?.lowercased()
            let result =  try! model.prediction(text: txtFromUser.text!);
            lblSentiment.text = result.label
        }
    
    }
    
}

