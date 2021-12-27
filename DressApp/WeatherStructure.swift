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
    var weather: [Weather]
    var wind: Wind

    
    struct MainResponse: Decodable {
        var temp: Double
        var humidity: Double
        var temp_max: Double
        var temp_min: Double
        var feels_like: Double
    }
    
    struct Weather: Decodable{
        var main: String
        var description: String
        var icon: String
    }
//    
    struct Wind: Decodable{
        var speed: Double
    }
//    
//    struct Rain: Codable {
//        var lastHour: Float?
//        var last3Hours: Float?
//        private enum CodingKeys: String, CodingKey {
//            case lastHour = "1h"
//            case last3Hours = "3h"
//        }
//    }
//    
//    struct Snow: Codable {
//        var lastHour: Float?
//        var last3Hours: Float?
//        private enum CodingKeys: String, CodingKey {
//            case lastHour = "1h"
//            case last3Hours = "3h"
//        }
//    }
//    struct Cloud: Codable {
//        var percentage: Int?
//        private enum CodingKeys: String, CodingKey {
//            case percentage = "all"
//        }
//    }
    
    
    
    
}
