//
//  SearchFunctions.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/16/20.
//

import Foundation
import UIKit

//MARK: Search Functionality Function
extension TableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            arr = search
            tblView.reloadData()
            return
        }
        arr = search.filter({ (stock) -> Bool in
            stock.symbol.lowercased().contains(searchText.lowercased())
        })
        tblView.reloadData()
        
//        let searchText = searchBar.text!;
//        // if search text is not empty then proceed else return
//        guard !searchText.isEmpty else {
//            arr = search;
//            tblView.reloadData()
//            return
//        }
    }
}
