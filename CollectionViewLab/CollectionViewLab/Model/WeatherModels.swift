//
//  WeatherModels.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct Location: Decodable{
    let title: String
    let woeid: Int
}

struct WeatherWrapper: Decodable{
    let consolidatedWeather: [Weather]
    
    enum CodingKeys: String, CodingKey{
        case consolidatedWeather = "consolidated_weather"
    }
}

struct Weather: Decodable{
    let currentWeather: String
    
    enum CodingKeys: String, CodingKey{
        case currentWeather = "weather_state_name"
    }
}
