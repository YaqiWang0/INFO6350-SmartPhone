//
//  DashboardViewController.swift
//  TwitterClone
//
//  Created by Yaqi Wang on 11/26/20.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logout_Action(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            let keyChain = KeychainService().keyChain
            keyChain.delete("uid")
            self.navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
}
