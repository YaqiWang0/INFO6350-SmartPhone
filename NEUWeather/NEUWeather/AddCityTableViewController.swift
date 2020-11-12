//
//  AddCityTableViewController.swift
//  NEUWeather
//
//  Created by Yaqi Wang on 11/11/20.
//

import UIKit
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit
import RealmSwift


class AddCityTableViewController: UITableViewController, UISearchBarDelegate{

    @IBOutlet var tblView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var arr : [CityInfo] = [CityInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        print(Realm.Configuration.defaultConfiguration.fileURL)
        delCities()
    }
    
    func delCities () {
        do {
            let realm = try Realm()
            let cities = realm.objects(CityInfo.self)
            for city in cities {
                deleteCity(city)
            }
        } catch {
            print("Error")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "\(arr[indexPath.row].name),  \(arr[indexPath.row].adminArea), \(arr[indexPath.row].country)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = arr[indexPath.row]
        let alert = UIAlertController(title: "Add city", message: "Do you want to see weather for \(city.name)", preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "OK", style: .default) { (action) in
            self.addCityToDB(city)
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel pressed")
        }
        
        alert.addAction(OK)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // This function returns (Temp, Forecast)
    func getCityNames(cityStr : String) {
        let url = "\(autoCompleteCity)\(cityStr)&apikey=\(apiKey)"
        AF.request(url).responseJSON { (response) in
            if response.error != nil {
                print(response.error)
            }
            let citiesJSON : [JSON] = JSON(response.data!).arrayValue
            self.arr = [CityInfo]()
            for city in citiesJSON {
                let key = city["Key"].stringValue
                let name = city["LocalizedName"].stringValue
                let country = city["Country"]["LocalizedName"].stringValue
                let adminArea = city["AdministrativeArea"]["LocalizedName"].stringValue
                let curCity = CityInfo(key, name, country, adminArea)
                self.arr.append(curCity)
            }
            self.tblView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            arr = [CityInfo]()
            tblView.reloadData()
            return
        }
        
        if searchText.count < 2 {
            return
        }
        getCityNames(cityStr: searchText)
    }
    
    func addCityToDB(_ city : CityInfo) {
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(city, update: .all)
            })
        } catch {
            print("Error in writing to Database")
        }
    }
    
    func deleteCity(_ city : CityInfo) {
        do {
            let realm = try Realm()
            try realm.write ({
                    realm.delete(city)
                })
        } catch {
            print("Error")
        }
    }

}
