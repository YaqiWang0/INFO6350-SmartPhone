//
//  ViewController.swift
//  TwitterClone
//
//  Created by Yaqi Wang on 11/24/20.
//

import UIKit
import Firebase
import SwiftSpinner

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var tbnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initString()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = KeychainService().keyChain
        if keyChain.get("uid") != nil {
            performSegue(withIdentifier: "dashboardSegue", sender: self)
        }
        txtPassword.text = ""
    }
    
    func initString() {
        txtEmail.placeholder = strEMail
        txtPassword.placeholder = strPassword
        lblStatus.text = strStatus
        tbnLogin.setTitle(strLogin, for: .normal)
    }
    
    func addKeychainAfterLogin(_ uid : String) {
        let keyChain = KeychainService().keyChain
        keyChain.set(uid, forKey: "uid")
    }

    @IBAction func login_action(_ sender: Any) {
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        if email == "" || password == "" || password.count < 6 {
            lblStatus.text = strEmailPasswordBlank
            return
        }
        
        if email.isEmail == false {
            lblStatus.text = strInvalidEmail
            return 
        }
        
        SwiftSpinner.show("Logging in")
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            SwiftSpinner.hide()
            guard let strongSelf = self else { return }
            
            if error != nil {
                self?.lblStatus.text = error?.localizedDescription
                return
            }
            
            let uid = Auth.auth().currentUser?.uid
            
            strongSelf.addKeychainAfterLogin(uid!)
            
            strongSelf.performSegue(withIdentifier: "dashboardSegue", sender: strongSelf)
        }
    }
}

