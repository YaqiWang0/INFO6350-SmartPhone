//
//  Utilities.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/15/20.
//

import Foundation

let apiKey = "56f622a93b55019c5a0875058fc58f13";
let apiURL = "https://financialmodelingprep.com/api/v3/profile/";


func getURL(_ arr : [StockProfile]) -> String{
    var url = apiURL
    for stock in arr {
        url.append(stock.symbol)
        url.append(",")
    }
    url = String(url.dropLast())
    url.append("?apikey=\(apiKey)")
    return url
}

func getURL(symbol : String) -> String{
    var url = apiURL
    url.append(symbol)
    url.append("?apikey=\(apiKey)")
    return url
}

