//
//  ForgotPasswordViewController.swift
//  LoginApp
//
//  Created by Yaqi Wang on 11/16/20.
//

import UIKit
import Firebase
import SwiftSpinner

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendEmail(_ sender: Any) {
        let email = txtEmail.text
        if email == "" {
            txtStatus.text = "Please enter email"
            return
        }
        if email?.isEmail == false {
            txtStatus.text = "Please enter valid email"
            return
        }
        SwiftSpinner.show("Sending Email ...")

        Auth.auth().sendPasswordReset(withEmail: email!, completion: { (error) in
            SwiftSpinner.hide()
            if error != nil {
                self.txtStatus.text = error?.localizedDescription
                return;
            }
            self.navigationController?.popViewController(animated: true)
        })
    }
}
