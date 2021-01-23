//
//  Weather.swift
//  WeatherApp
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import Foundation

struct WeatherDetails: Decodable {
    let weatherCondition: String
    let weatherConditionAbbreviation: String
    let time: String?
    let temperature: Int?
    let airPressure: Float?
    let windSpeed: Float?
    let windDirection: Float?
    let humidity: Int?
    let visibility: Float?
    let predictability: Int?
    let imageUrlString: String
    
    private enum  CodingKeys: String, CodingKey {
        case weatherCondition = "weather_state_name"
        case weatherConditionAbbreviation = "weather_state_abbr"
        case time = "created"
        case temperature = "the_temp"
        case airPressure = "air_pressure"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case visibility = "visibility"
        case humidity = "humidity"
        case predictability = "predictability"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weatherCondition = try container.decode(String.self, forKey: .weatherCondition)
        weatherConditionAbbreviation = try container.decode(String.self, forKey: .weatherConditionAbbreviation)
        imageUrlString = "\(API.baseUrlImage)\(weatherConditionAbbreviation).png"
        let dateString = try container.decode(String.self, forKey: .time)
        let formatter = DateFormatter.iso8601Full
        if let date = formatter.date(from: dateString) {
            time =  DateFormatter.time.string(from: date)
        } else {
            time = ""
        }
        let temp = try container.decodeIfPresent(Float.self, forKey: .temperature)
        if let tempValue = temp {
            temperature = Int(tempValue)
        } else {
            temperature = 0
        }
        airPressure = try container.decodeIfPresent(Float.self, forKey: .airPressure)
        windSpeed = try container.decodeIfPresent(Float.self, forKey: .windSpeed)
        windDirection = try container.decodeIfPresent(Float.self, forKey: .windDirection)
        humidity = try container.decodeIfPresent(Int.self, forKey: .humidity)
        visibility = try container.decodeIfPresent(Float.self, forKey: .visibility)
        predictability = try container.decodeIfPresent(Int.self, forKey: .predictability)
      }
}
