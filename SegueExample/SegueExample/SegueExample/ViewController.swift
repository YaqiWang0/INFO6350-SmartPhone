//
//  ViewController.swift
//  SegueExample
//
//  Created by Yaqi Wang on 10/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func gotoNextScreen(_ sender: UIButton) {
        performSegue(withIdentifier: "segueNextScreen", sender: self)
    }
    

}

