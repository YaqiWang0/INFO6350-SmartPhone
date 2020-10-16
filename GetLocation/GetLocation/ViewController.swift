//
//  ViewController.swift
//  GetLocation
//
//  Created by Yaqi Wang on 10/16/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var txtLatitute: UILabel!
    @IBOutlet weak var txtLongitute: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func getLocation(_ sender: UIButton) {
        locationManager.requestLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in getting location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currLocation = locations.last else {return}
        
        txtLatitute.text = String(currLocation.coordinate.latitude)
        txtLongitute.text = String(currLocation.coordinate.longitude)
    }
    
}

