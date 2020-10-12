//
//  TableViewController.swift
//  StockUpdate
//
//  Created by Yaqi Wang on 10/12/20.
//

import UIKit

class TableViewController: UITableViewController {

    var arr = [StockData]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...

        return cell
    }

}
