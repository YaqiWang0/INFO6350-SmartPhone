//
//  ViewController.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/12/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController {

    let apiKey = "56f622a93b55019c5a0875058fc58f13";
    let apiURL = "https://financialmodelingprep.com/api/v3/quote-short/";
    
    @IBOutlet weak var txtStockName: UITextField!
    
    @IBOutlet weak var lblStockValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getStockValue(_ sender: Any) {
        guard let stockName = txtStockName.text else { return }
        print(stockName)
        let url = "\(apiURL)\(stockName)?apikey=\(apiKey)";
        getStockValue(stockURL: url, stockName: stockName);
        
    }
    
    func getStockValue(stockURL : String!, stockName : String!) {
        SwiftSpinner.show("Getting Stock Value for \(String(describing: stockName))")
        Alamofire.request(stockURL)
            .responseJSON { (response) in
            SwiftSpinner.hide();
            if response.result.isSuccess {
                guard let jsonString = response.result.value else {return}
                
                guard let stockJSON : [JSON] = JSON(jsonString).array else {return}
                if stockJSON.count < 1 {return}
                guard let symbol = stockJSON[0]["symbol"].rawString() else {return};
                guard let price = stockJSON[0]["price"].double else {return};
                
                print(price);
                print(symbol);
                
                self.lblStockValue.text = "Price for \(symbol) = \(price)"
            }
        }
    }
}

