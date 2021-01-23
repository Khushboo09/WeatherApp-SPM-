//
//  WeatherAPITest.swift
//  WeatherAppTests
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import XCTest

@testable import WeatherApp
final class DigitalLeafletAPITest: XCTestCase {
    
    func testfetchLocationSearchAPICallSuccess() {
        let mockSuccessAdapter = MockNetworkAdaptor<Location>(fileName: "weather_location_search")
        let weatherViewModel = WeatherViewModel(networkAdaptor: mockSuccessAdapter)
        weatherViewModel.fetchwoeId(location: "london") { (error) in
            XCTAssertNil(error)
            XCTAssertNotNil(weatherViewModel.woeId)
        }
    }
    
    func testfetchLocationAPICallSuccess() {
        let mockSuccessAdapter = MockNetworkAdaptor<Weather>(fileName: "weather_location")
        let weatherViewModel = WeatherViewModel(networkAdaptor: mockSuccessAdapter)
        weatherViewModel.fetchWeatherList { (error) in
            XCTAssertNil(error)
            XCTAssertNotNil(weatherViewModel.weatherList)
            XCTAssertFalse(weatherViewModel.weatherList.isEmpty)
        }
    }
}
