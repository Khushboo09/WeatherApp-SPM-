//
//  SelectLocationViewController.swift
//  WeatherApp
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import Foundation
import UIKit

class SelectLocationViewController: UIViewController {
    
    @IBOutlet var citytableView: UITableView! {
        didSet {
            citytableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.CellIdentifier.cityCell)
            citytableView.tableFooterView = UIView(frame: .zero)
        }
    }
    var selectedCity:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citytableView.delegate = self
        citytableView.dataSource = self
    }
}

extension SelectLocationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.cityCell)!
        cell.textLabel?.text = City.cityArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return City.cityArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = City.cityArray[indexPath.row]
        performSegue(withIdentifier: Constant.segueIdentifier.weatherSegue, sender: self)
    }
}



