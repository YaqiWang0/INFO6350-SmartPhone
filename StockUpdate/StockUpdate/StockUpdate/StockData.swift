//
//  StockData.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/12/20.
//

import Foundation

class StockData {
    var symbol : String! = "";
    var price : Double! = 0.0;
    var volumn : Int64 = 0;
    
    init(symbol : String!, price: Double!, volumn: Int64) {
        self.symbol = symbol;
        self.price = price;
        self.volumn = volumn;
    }
}
