//
//  ViewController.swift
//  NEUWeather
//
//  Created by Yaqi Wang on 11/10/20.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit

class ViewController: UIViewController, CLLocationManagerDelegate {


    @IBOutlet weak var txtLat: UILabel!
    @IBOutlet weak var txtLng: UILabel!
    @IBOutlet weak var txtCityName: UILabel!
    @IBOutlet weak var txtTemperature: UILabel!
    @IBOutlet weak var txtForecast: UILabel!
    @IBOutlet weak var txtMaxTemp: UILabel!
    @IBOutlet weak var txtMinTemp: UILabel!
    
    let locationManager = CLLocationManager();
    
    var lat : CLLocationDegrees?
    var lng : CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization();
        locationManager.requestLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in getting Location : \(error)");
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currLocation = locations.last {
            lat = currLocation.coordinate.latitude
            lng = currLocation.coordinate.longitude
            txtLat.text = "Latitude : \(lat!)"
            txtLng.text = "Longitude : \(lng!)"
            print(lat!)
            print(lng!)
        }
    }
    
    func getLocalWeather(_ lat : CLLocationDegrees, _ lng : CLLocationDegrees) {
        let url = getURLCurrentLocation(lat, lng)
        AF.request(url).responseJSON { (response) in
            if response.error != nil {
                print(response.error!)
                return
            }
            let currJSON : JSON = JSON(response.data)
            print(currJSON);
        }
        
    }
    
    func getURLCurrentLocation(_ lat : CLLocationDegrees, _ lng : CLLocationDegrees) -> String{
        var url = getPositionURL;
        url.append("apikey=\(apiKey)&q=\(lat),\(lng)")
        return url
    }

    @IBAction func getWeather(_ sender: Any) {
        guard let latitude = lat, let longitude = lng else {return}
        let url = getURLCurrentLocation(latitude, longitude)
        getLocationData(for: url).done { (key, city) in
            self.txtCityName.text = "City Name : \(city)"
            
            self.getOneHourForecast(for: key).done { (temp, forecast) in
                self.txtTemperature.text = "Current Temperature : \(temp)"
                self.txtForecast.text = "Forecast : \(forecast)"
            }
            .catch { (error) in
                print(error)
            }
            
            self.getOneDayForecast(for: key).done { (min, max) in
                self.txtMinTemp.text = "Min Temperature : \(min)"
                self.txtMaxTemp.text = "Max Temperature : \(max)"
            }
            .catch { (error) in
                print(error)
            }
            
        }
        .catch { (error) in
            print(error)
        }
    }
    
    func getOneDayForecast(for key : String) -> Promise<(Int, Int)> {
        return Promise<(Int, Int)> { seal -> Void in
            
            let url = "\(oneDayURL)\(key)?apikey=\(apiKey)"
            AF.request(url).responseJSON { (response) in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                let oneDayJson : JSON = JSON(response.data!);
                let min = oneDayJson["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].intValue
                let max = oneDayJson["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].intValue
                seal.fulfill((min, max))
            }
        }
    }
    
    // This function returns (Temp, Forecast)
    func getOneHourForecast(for key : String) -> Promise<(Int, String)> {
        return Promise<(Int, String)> { seal -> Void in
            
            let url = "\(oneHourURL)\(key)?apikey=\(apiKey)"
            AF.request(url).responseJSON { (response) in
                if response.error != nil {
                    seal.reject(response.error!)
                }
                let oneHourJson : JSON = JSON(response.data!);
                let forecast = oneHourJson[0]["IconPhrase"].stringValue
                let temp = oneHourJson[0]["Temperature"]["Value"].intValue
                seal.fulfill((temp, forecast))
            }
        }
    }
    
    // this function return (City Key, City Name)
    func getLocationData(for url : String) -> Promise<(String, String)> {
        return Promise<(String, String)> { seal -> Void in
            AF.request(url).responseJSON { (response) in
                if response.error != nil {
                    seal.reject(response.error!);
                }
                let currJSON : JSON = JSON(response.data)
                
                var key = ""
                var cityName = ""
                
                if currJSON["ParentCity"].exists() {
                    key = currJSON["ParentCity"]["Key"].stringValue
                    cityName = currJSON["ParentCity"]["LocalizedName"].stringValue
                } else {
                    key = currJSON["Key"].stringValue;
                    cityName = currJSON["LocalizedName"].stringValue;
                }

                seal.fulfill((key, cityName))
            }
        } // end of promise
    }
}

