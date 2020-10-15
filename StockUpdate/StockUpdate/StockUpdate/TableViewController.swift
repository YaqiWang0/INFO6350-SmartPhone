//
//  TableViewController.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/12/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class TableViewController: UITableViewController {

    var arr = [StockProfile]()
    @IBOutlet var tblView: UITableView!
    
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arr.append(StockProfile("MSFT"));
        arr.append(StockProfile("AMZN"));
        
        if #available(iOS 10.0, *) {
            tblView.refreshControl = refresh;
        } else {
            tblView.addSubview(refresh);
        }
        
        refresh.addTarget(self, action: #selector(refreshStockData(_:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "Getting Stock Values")
    }
    
    @ objc private func refreshStockData(_ sender: Any) {
        refreshData()
    }
    
    @IBAction func refreshStockValues(_ sender: Any) {
        refreshData()
    }
    
    func refreshData() {
        let url = getURL()
        print(url);
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
                for stock in stocks {

                    let p : StockProfile = self.getStockProfileFromJSON(stock: stock);
                    if p.symbol == "NONE" {return}
                    self.arr.append(p);
                    
//                    print("*************")
//                    print(symbol);
//                    print(price);
//                    print(companyName);
//                    print(industry);
//                    print(website);
//                    print(description);
//                    print(ceo);
//                    print(fulltimeEmployees);
//                    print(imageURL);
//                    print("*************")
                }
//
                self.tblView.reloadData();

                
                //self.lblStockValue.text = "Price for \(symbol) = \(price)"
            }
        }
    }
    
    func getStockProfileFromJSON(stock : JSON) -> StockProfile {
        let symbol = stock["symbol"].rawString()
        let price = stock["price"].double
        let companyName = stock["companyName"].rawString()
        let industry = stock["industry"].rawString()
        let website = stock["website"].rawString()
        let description = stock["description"].rawString()
        let ceo = stock["ceo"].rawString()
        let fulltimeEmployees = stock["fulltimeEmployees"].rawString()
        //let imageURL = stock["image"].rawString()
        let stockProfile = StockProfile(symbol!)
        stockProfile.price = price!
        stockProfile.companyName = companyName!
        stockProfile.industry = industry!;
        stockProfile.website = website!;
        stockProfile.description = description!;
        stockProfile.ceo = ceo!;
        stockProfile.fulltimeEmployees = fulltimeEmployees!;
        
        return stockProfile;
    }
    
    func getURL() -> String{
        var url = apiURL
        for stock in arr {
            url.append(stock.symbol)
            url.append(",")
        }
        url = String(url.dropLast())
        url.append("?apikey=\(apiKey)")
        return url
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count;
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell;
        cell.lblPrice.text = "$\(String(describing: arr[indexPath.row].price))";
        cell.lblSymbol.text = arr[indexPath.row].symbol;

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arr.remove(at: indexPath.row);
            tblView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
