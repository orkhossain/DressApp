//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by Mohammad Azam on 8/11/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI

enum LoadingState {
    case none
    case loading
    case success
    case failed
}

enum TemperatureUnit: String, CaseIterable {
    case celsius
    case fahrenheit
}

extension TemperatureUnit {
    
    var title: String {
        switch self {
        case .celsius:
            return "C°"
        case .fahrenheit:
            return "F°"
            
        }
    }
    
}


class WeatherViewModel: ObservableObject {
    @Published private var weatherResponse:WeatherResponse?
    @Published var message: String = ""
    @Published var loadingState: LoadingState = .none
    @Published var temperatureUnit: TemperatureUnit = .celsius
    
    var temperature: String {
        guard let temp = weatherResponse?.main.temp else {
            return "N/A"
        }
        switch temperatureUnit {
        case .fahrenheit:
            return String(format: "%.0F F°", temp.toFahrenheit())
        case .celsius:
            return String(format: "%.0F C°", temp.toCelsius())
        }

    }

    var humidity: String {
        guard let humidity = weatherResponse?.main.humidity else {
            return "N/A"
        }
        return String(format: "%.0F %%", humidity)
    }
    
    var city: String {
        guard let name = weatherResponse?.name else {
            return "N/A"
        }
        return name
    }
    
    var temperature_max: String {
        guard let temp_max = weatherResponse?.main.temp_max else {
            return "N/A"
        }
        switch temperatureUnit {
        case .fahrenheit:
            return String(format: "%.0F F°", temp_max.toFahrenheit())
        case .celsius:
            return String(format: "%.0F C°", temp_max.toCelsius())
        }
    }
    
    var temperature_min: String {
        guard let temp_min = weatherResponse?.main.temp_min else {
            return "N/A"
        }
        switch temperatureUnit {
        case .fahrenheit:
            return String(format: "%.0F F°", temp_min.toFahrenheit())
        case .celsius:
            return String(format: "%.0F C°", temp_min.toCelsius())
        }
    }

//    var icon: String {
//        guard let icon = responseBody?.weather[0].icon else {
//            return "N/A"
//        }
//        return icon
//    }
//    
    
    
    func fetchWeather(latitude: Double, longitude: Double) {
                
        WeatherService().getWeather(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let weatherResponse):
                DispatchQueue.main.async {
                    self.weatherResponse = weatherResponse
                    self.loadingState = .success
                }
            case .failure(_ ):
                DispatchQueue.main.async {
                    self.message = "Unable to find weather"
                    self.loadingState = .failed
                }
            }
        }
        
    }
    
}
