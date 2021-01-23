//
//  WeatherDetailTableViewController.swift
//  WeatherApp
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import Foundation
import UIKit
import SDWebImage

class WeatherDetailTableViewController: UITableViewController {
    
    var weatherDetail:WeatherDetails?
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        guard let weather = weatherDetail else {
            return
        }
        temperatureLabel.text = "\(weather.temperature ?? 0)°"
        weatherStateLabel.text = weather.weatherCondition
        if let url = URL(string: weather.imageUrlString) {
            weatherImageView.sd_setImage(with: url, placeholderImage: nil, options: [], progress: nil, completed: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.weatherDetailCell, for: indexPath)
        
        guard let weather = weatherDetail else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Air Pressure"
            cell.detailTextLabel?.text = "\(weather.airPressure ?? 0) mbar"
        case 1:
            cell.textLabel?.text = "Wind Speed"
            cell.detailTextLabel?.text = "\(weather.windSpeed ?? 0) mph"
        case 2:
            cell.textLabel?.text = "Wind Direction"
            cell.detailTextLabel?.text = "\(weather.windDirection ?? 0)°"
        case 3:
            cell.textLabel?.text = "Humidity"
            cell.detailTextLabel?.text = "\(weather.humidity ?? 0)%"
        case 4:
            cell.textLabel?.text = "Visibility"
            cell.detailTextLabel?.text = "\(weather.visibility ?? 0) miles"
        case 5:
            cell.textLabel?.text = "Predictability"
            cell.detailTextLabel?.text = "\(weather.predictability ?? 0)%"
        default:
            print("")
        }
        return cell
    }
    
}
