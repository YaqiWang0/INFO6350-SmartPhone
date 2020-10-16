//
//  StockProfile.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/15/20.
//

import Foundation
import RealmSwift

class StockProfile: Object {
    @objc dynamic var symbol: String! = ""
    @objc dynamic var price : Double = 0.0
    @objc dynamic var companyName : String! = ""
    @objc dynamic var industry : String! = ""
    @objc dynamic var website : String! = ""
    //@objc dynamic var description : String! = ""
    @objc dynamic var ceo : String! = ""
    @objc dynamic var fulltimeEmployees : String! = ""
    @objc dynamic var imageURL : String! = ""
    
    init(_ symbol : String) {
        super.init()
        self.symbol = symbol;
    }
    
    required init() {
    }
    
    override static func primaryKey() -> String? {
        return "symbol";
    }
}
