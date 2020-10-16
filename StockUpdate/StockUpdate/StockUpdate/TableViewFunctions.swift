//
//  TableViewFunctions.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/16/20.
//

import Foundation
import UIKit

//MARK: Table view funtionality
extension TableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell;
        cell.lblPrice.text = "$\(String(describing: arr[indexPath.row].price))";
        cell.lblSymbol.text = arr[indexPath.row].symbol;
        cell.lblCompanyName.text = arr[indexPath.row].companyName;

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let stock = arr[indexPath.row];
            deleteStock(stock: stock);
            arr.remove(at: indexPath.row);
            search.remove(at: indexPath.row);
            tblView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
