//
//  ViewController.swift
//  HelloWorld
//
//  Created by Yaqi Wang on 9/10/20.
//  Copyright © 2020 Yaqi Wang. All rights reserved.
//

import UIKit

class HelloWorldViewController: UIViewController {

    @IBOutlet weak var lblHello: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("I am inside View Did load")
        // Do any additional setup after loading the view.
    }


    @IBAction func satHello(_ sender: UIButton) {
        lblHello.text = "hello world";
        lblHello.textColor = .red;
    }
    
}

