//
//  StringExtensions.swift
//  TwitterClone
//
//  Created by Yaqi Wang on 11/26/20.
//

import Foundation

extension String {
    var isEmail : Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
