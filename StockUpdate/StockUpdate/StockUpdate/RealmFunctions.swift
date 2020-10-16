//
//  RealmFunctions.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/16/20.
//

import Foundation
import RealmSwift

//MARK: Realm functions
extension TableViewController {
    func loadValuesFromDatabase() {
        do {
            let realm = try Realm() // singleton
            let stocks = realm.objects(StockProfile.self)
            for stock in stocks {
                arr.append(stock)
            }
            search = arr
        }
        catch {
            print("Error in reading database \(error)")
        }
    }
    
    func addStockToDatabase(stock : StockProfile) {
        do {
            let realm = try Realm() //singleton
            try realm.write({
                realm.add(stock, update: .all)
            })
            arr.append(stock)
            search.append(stock)
            tblView.reloadData()
        }
        catch {
            print("Error in adding values in database \(error)")
        }
    }
    
    func updateDataInDB() {
        do {
            let realm = try Realm()
            for stock in arr {
                try realm.write({
                    realm.add(stock, update: .all)
                })
            }//singleton
            
            tblView.reloadData()
        }
        catch {
            print("Error in adding values in database \(error)")
        }
    }
    
    func deleteStock(stock : StockProfile) {
        do {
            let realm = try Realm()
            try realm.write({
                realm.delete(stock)
            })
        } catch {
            print("Error in deleting values in database \(error)")
        }
    }
}
