//
//  StockProfile.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/15/20.
//

import Foundation

class StockProfile {
    var symbol: String! = ""
    var price : Double = 0.0
    var companyName : String! = ""
    var industry : String! = ""
    var website : String! = ""
    var description : String! = ""
    var ceo : String! = ""
    var fulltimeEmployees : String! = ""
    var imageURL : String! = ""
    
    init(_ symbol : String) {
        self.symbol = symbol;
    }
}
