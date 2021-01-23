//
//  Location.swift
//  WeatherApp
//
//  Created by Khushboo Kochhar on 23/01/21.
//

import Foundation

struct Location: Decodable {
    let locationName: String
    let woeId: Int
    let locationType: String
    let locationCoordinates: String
    
   enum CodingKeys: String, CodingKey {
        case locationName = "title"
        case woeId = "woeid"
        case locationType = "location_type"
        case locationCoordinates = "latt_long"
    }
    
  init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        locationName = try container.decode(String.self, forKey: .locationName)
        woeId = try container.decode(Int.self, forKey: .woeId)
        locationType = try container.decode(String.self, forKey: .locationType)
        locationCoordinates = try container.decode(String.self, forKey: .locationType)
    }
}

