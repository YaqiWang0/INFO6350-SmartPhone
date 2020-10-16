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
import RealmSwift

class TableViewController: UITableViewController{

    //arrays for table view
    var arr = [StockProfile]()
    var search = [StockProfile]()
    
    //outlets
    @IBOutlet var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let refresh = UIRefreshControl()
    
    //text field for Alert controller
    var textField = UITextField();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeValues()
    }
    
    // initialize values when app starts up
    func initializeValues() {
        
        //Refresh control
        if #available(iOS 10.0, *) {
            tblView.refreshControl = refresh;
        } else {
            tblView.addSubview(refresh);
        }
        
        refresh.addTarget(self, action: #selector(refreshStockData(_:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "Getting Stock Values")
        
        searchBar.delegate = self
        
        loadValuesFromDatabase()
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    @ objc private func refreshStockData(_ sender: Any) {
        refreshData()
    }
    
    @IBAction func refreshStockValues(_ sender: Any) {
        refreshData()
    }
    
    @IBAction func addNewStock(_ sender: Any) {
        let alert = UIAlertController(title: "Add Stock", message: "Type Stock Symbol", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let symbol = self.textField.text else {return}
            self.getStockData(symbol: symbol)
            print("OK pressed")
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            print("Cancel pressed")
        }
        alert.addTextField { (stockTextField) in
            stockTextField.placeholder = "Type Stock Symbol";
            self.textField = stockTextField;
        }
        alert.addAction(OK);
        alert.addAction(cancel);
        
        self.present(alert, animated: true, completion: nil)
    }
}
