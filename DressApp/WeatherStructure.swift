//
//  WeatherStructure.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 19/12/2021.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
