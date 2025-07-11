//
//  WeatherData.swift
//  Clima
//
//  Created by Lajim Mulla on 18/03/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable{
    let id: Int
}
