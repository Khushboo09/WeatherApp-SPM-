//
//  Constant.swift
//  WeatherApp
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import Foundation


struct API {
    static let baseUrl = "https://www.metaweather.com/api/"
    static let baseUrlImage = "https://www.metaweather.com/static/img/weather/png/64/"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Weather: Endpoint {
    case fetchLocation
    case fetchWeatherForTomorrow
        
    public var path: String {
        switch self {
        case .fetchLocation: return "location/search/"
        case .fetchWeatherForTomorrow: return "location/"
        }
    }
        
    public var url: String {
        return  "\(API.baseUrl)\(path)"
    }
}

struct Constant {
    struct CellIdentifier {
        static let listCell = "WeatherTableViewCell"
        static let cityCell = "CityTableViewCell"
        static let weatherDetailCell = "WeatherDetailCell"
    }
    
    struct VCIdentifier {
        static let weatherDetailVC = "WeatherDetailTableViewController"
    }
    
    struct segueIdentifier {
        static let weatherSegue = "unwindToWeatherVC"
    }
    
}

struct LocalizationConstant {
    static let internetError = "No Internet Connection"
    static let otherError = NSLocalizedString("otherError", comment: "")
    static let noDataError = NSLocalizedString("noDataError", comment: "")
}

struct City {
    static let cityArray: [String] = ["Gothenburg","Stockholm","Mountain View","London","New York","Berlin"]
}
