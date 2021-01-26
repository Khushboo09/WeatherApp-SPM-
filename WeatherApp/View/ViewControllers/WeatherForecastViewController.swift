//
//  ViewController.swift
//  WeatherApp
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import UIKit
import Toast
import SDWebImage

class WeatherForecastViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = WeatherViewModel()
    @IBOutlet weak var locationButton: UIButton!
    var selectedLocation: String = City.cityArray.first ?? "london" {
        didSet {
            locationButton.setTitle(selectedLocation, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationButton.setTitle(selectedLocation, for: .normal)
        self.fetchLocationDetail()
    }
    
    @IBAction func unwind( _ segue: UIStoryboardSegue) {
        guard let selectLocationvc = segue.source as? SelectLocationViewController,
              let selectedCity = selectLocationvc.selectedCity else {
            return
        }
        selectedLocation = selectedCity
        self.fetchLocationDetail()
    }
    
    private func fetchLocationDetail() {
        guard ConnectivityManager.isConnectedToInternet() else {
            self.showError(errorMessage: LocalizationConstant.internetError)
            return
        }
        self.view.makeToastActivity(.center)
        viewModel.fetchwoeId(location: selectedLocation) {[weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.view.hideToastActivity()
                self.showError(errorMessage: error.localizedDescription)
            } else {
                self.fetchWeatherForecastDetail()

            }
        }
    }
    
    private func fetchWeatherForecastDetail() {
        viewModel.fetchWeatherList({[weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.view.hideToastActivity()
                self.showError(errorMessage: error.localizedDescription)
            } else {
                self.view.hideToastActivity()
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        })
    }
    
    private func showError(errorMessage: String) {
        DispatchQueue.main.async {
            var style = ToastStyle()
            style.messageColor = UIColor.white
            style.backgroundColor = UIColor.black
            self.view.makeToast(errorMessage, duration: 2.0, position: .bottom, style: style)
        }
    }
}

extension WeatherForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.listCell) as! WeatherTableViewCell
        cell.timeLabel.text = viewModel.weatherList[indexPath.row].time
        cell.temperatureLabel.text = "\(viewModel.weatherList[indexPath.row].temperature ?? 0)°"
        cell.weatherConditionLabel.text = viewModel.weatherList[indexPath.row].weatherCondition
        let imgURLString = viewModel.weatherList[indexPath.row].imageUrlString
        let url = URL(string: imgURLString)
        cell.weatherImageView.sd_setImage(with: url, placeholderImage: nil, options: [], progress: nil, completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherList.count 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = UIColor(red: 187.0/255.0, green: 122.0/255.0, blue: 38.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.size.width-20, height: view.frame.size.height))
        label.text = Date.tomorrow.toDayString()
        label.textColor = UIColor.white
        view.addSubview(label)
        return view
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension WeatherForecastViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let weatherDetailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: Constant.VCIdentifier.weatherDetailVC) as? WeatherDetailTableViewController else {
            return
        }
        weatherDetailVC.weatherDetail = viewModel.weatherList[indexPath.row]
        self.navigationController?.pushViewController(weatherDetailVC, animated: true)
    }
}


