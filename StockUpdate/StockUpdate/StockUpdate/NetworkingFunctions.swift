//
//  NetworkingFunctions.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/16/20.
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK: Networking funtionality
extension TableViewController {
    func refreshData() {
        let url = getURL(arr)
        
        //SwiftSpinner.show("Getting Stock Values")
        Alamofire.request(url)
            .responseJSON { (response) in
            //SwiftSpinner.hide();
                self.refresh.endRefreshing();
            if response.error == nil {
                
                //Get JSON String and convert it into JSON array
                guard let jsonString = response.data else {return}
                guard let stocks : [JSON] = JSON(jsonString).array else {return}
                
                //if there are no stocks return
                if stocks.count < 1 {return}
                
                // Re initialize the stock values
                self.arr.removeAll();
                self.search.removeAll()
                for stock in stocks {
                    let p : StockProfile = self.getStockProfileFromJSON(stock: stock);
                    if p.symbol == "NONE" {return}
                    self.arr.append(p);
                    self.search.append(p);
                }
                self.tblView.reloadData();
                self.updateDataInDB();
                //self.lblStockValue.text = "Price for \(symbol) = \(price)"
            }
        }
    }
    
    func getStockData(symbol : String) {
        let url = getURL(symbol: symbol)
        Alamofire.request(url).responseJSON { (response) in
            if response.error == nil {
                
                //Get JSON String and convert it into JSON array
                guard let jsonString = response.data else {return}
                guard let stocks : [JSON] = JSON(jsonString).array else {return}
                
                if stocks.count < 1 {return}
                let p : StockProfile = self.getStockProfileFromJSON(stock: stocks[0]);
                print(p)
                self.addStockToDatabase(stock: p)
            }
        }
    }
    
    func getStockProfileFromJSON(stock : JSON) -> StockProfile {
        let symbol = stock["symbol"].rawString()
        let price = stock["price"].double
        let companyName = stock["companyName"].rawString()
        let industry = stock["industry"].rawString()
        let website = stock["website"].rawString()
        //let description = stock["description"].rawString()
        let ceo = stock["ceo"].rawString()
        let fulltimeEmployees = stock["fulltimeEmployees"].rawString()
        //let imageURL = stock["image"].rawString()
        let stockProfile = StockProfile(symbol!)
        stockProfile.price = price!
        stockProfile.companyName = companyName!
        stockProfile.industry = industry!;
        stockProfile.website = website!;
        //stockProfile.description = description!;
        stockProfile.ceo = ceo!;
        stockProfile.fulltimeEmployees = fulltimeEmployees!;
        
        return stockProfile;
    }
}
