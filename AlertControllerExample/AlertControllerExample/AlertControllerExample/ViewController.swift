//
//  ViewController.swift
//  AlertControllerExample
//
//  Created by Yaqi Wang on 10/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showAlert(_ sender: Any) {
        let alert = UIAlertController(title: "This is Title", message: "This is message", preferredStyle: .alert);
        let OK = UIAlertAction(title: "OK", style: .default) { (action) in
            print("OK Pressed");
        };
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            print("Cancel Pressed");
        };
        alert.addAction(cancel);
        alert.addAction(OK);
        
        self.present(alert, animated: true, completion: nil);
    }
    
}

