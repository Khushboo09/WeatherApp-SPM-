//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import Foundation
import UIKit

typealias locationDetailCompletion = (_ locationList: [Location]?,_ error: APIError?) -> Void
typealias onCompletion = (_ error: APIError?) -> Void
typealias weatherDetailCompletion = (_ weatherList: [WeatherDetails]?,_ error: APIError?) -> Void

final class WeatherViewModel {
    
    fileprivate let networkAdaptor: NetworkAdaptor
    fileprivate(set) var woeId: Int?
    fileprivate(set) var weatherList: [WeatherDetails] = []
    
    init(networkAdaptor: NetworkAdaptor = NetworkManager()) {
        self.networkAdaptor = networkAdaptor
    }
    
    private func fetchLocationDetails(location: String,_ completion: @escaping locationDetailCompletion) {
        var components = URLComponents(string: Weather.fetchLocation.url)!
        components.queryItems = [
            URLQueryItem(name: "query", value: location)
        ]
        let request = URLRequest(url: components.url!)
        networkAdaptor.fetch(with: request, type: [Location].self) { response in
            switch response {
            case .success(let result):
                completion(result,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    func fetchwoeId(location: String,_ completion: @escaping onCompletion) {
        fetchLocationDetails(location: location) { (locationSearchList, error) in
            if let error = error {
                completion(error)
            } else {
                guard let locationSearchList = locationSearchList else {
                    completion(nil)
                    return
                }
                self.woeId = locationSearchList.first?.woeId
                completion(nil)
            }
        }
    }
    
    private func fetchWeatherDetailsForTomorrow(_ completion: @escaping weatherDetailCompletion) {
        guard let woeid = self.woeId else {return}
        let url = URL(string: Weather.fetchWeatherForTomorrow.url + "\(woeid)/" + "\(Date.tomorrow.toString())/")!
        let request = URLRequest(url: url)
        networkAdaptor.fetch(with: request, type: [WeatherDetails].self) { response in
            switch response {
            case .success(let result):
                completion(result,nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    func fetchWeatherList(_ completion: @escaping onCompletion) {
        fetchWeatherDetailsForTomorrow { (weatherList, error) in
            if let error = error {
                completion(error)
            } else {
                guard let weatherList = weatherList else {
                    completion(nil)
                    return
                }
                self.weatherList = weatherList
                completion(nil)
            }
        }
    }
    
}
