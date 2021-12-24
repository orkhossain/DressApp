//
//  WeatherStructure.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 19/12/2021.
//

import Foundation

struct WeatherResponse: Decodable {
    var main: MainResponse
    var name: String
//    var weather : [Weather]
    
    struct MainResponse: Decodable {
        var temp: Double
        var humidity: Double
        var temp_max: Double
        var temp_min: Double
    }
    
//    struct Weather: Decodable{
//        var id: Double
//        var main: Double
//        var description: String
//        var icon: String
//    }
//
}
