//
//  ViewController.swift
//  TableViewCustomCell
//
//  Created by Yaqi Wang on 10/8/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var imageData = [ImageClass]()
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self;
        tblView.dataSource = self
        populateData();
        // Do any additional setup after loading the view.
    }
    func populateData() {
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "VolunteerPark"), title: "VolunteerPark"))
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "museumOfFlights"), title: "museumOfFlights"))
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "SpaceNeedle"), title: "SpaceNeedle"))
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "ComputersMuseum"), title: "ComputersMuseum"))
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "InternationalDistrict"), title: "InternationalDistrict"))
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "DiscoveryPark"), title: "DiscoveryPark"))
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "PioneerSquare"), title: "PioneerSquare"))
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "SculpturePark"), title: "SculpturePark"))
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "BallardLocks"), title: "BallardLocks"))
        imageData.append(ImageClass(image: #imageLiteral(resourceName: "GlassGarden"), title: "GlassGarden"))
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell;
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.cellImage.image = imageData[indexPath.row].image;
        cell.cellLabel.text = imageData[indexPath.row].title;
        return cell;
    }

}

