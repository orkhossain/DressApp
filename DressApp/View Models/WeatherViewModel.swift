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
    
    
    var feels_like: String {
        guard let feel_Like = weatherResponse?.main.feels_like else {
            return "N/A"
        }
        switch temperatureUnit {
        case .fahrenheit:
            return String(format: "%.0F F°", feel_Like.toFahrenheit())
        case .celsius:
            return String(format: "%.0F C°", feel_Like.toCelsius())
        }
    }
    
    var wind: String {
        guard let Wind = weatherResponse?.wind.speed else {
            return "N/A"
        }
        return String(Wind)
    }
    
    
    
    var icon: Image {
        guard let iconString = weatherResponse?.weather[0].icon else {
            return Image(systemName:"sun.max.fill")
        }
        
        switch iconString{
        case "01d":
            return  Image(systemName:"sun.max.fill")
        case "02d":
            return Image(systemName:"cloud.sun.fill")
        case "03d":
            return Image(systemName:"cloud.fill")
        case "04d":
            return Image(systemName:"smoke.fill")
        case "09d":
            return Image(systemName:"cloud.drizzle.fill")
        case "10d":
            return Image(systemName:"cloud.rain.fill")
        case "11d":
            return Image(systemName:"cloud.bolt.rain.fill")
        case "13d":
            return Image(systemName:"snow")
        case "50d":
            return Image(systemName:"cloud.fog.fill")
        case "01n":
            return Image(systemName:"moon.stars.fill")
        case "02n":
            return Image(systemName:"cloud.moon.fill")
        case "03n":
            return Image(systemName:"cloud.fill")
        case "04n":
            return Image(systemName:"smoke.fill")
        case "09n":
            return Image(systemName:"cloud.drizzle.fill")
        case "10n":
            return Image(systemName:"cloud.rain.fill")
        case "11n":
            return Image(systemName:"cloud.bolt.rain.fill")
        case "13n":
            return Image(systemName:"snow")
        case "50n":
            return Image(systemName:"cloud.fog.fill")
        case "loading":
            return Image(systemName:"goforward")
        case "wind" :
            return Image(systemName:"wind")
        case "sunrise":
            return Image(systemName:"sunrise.fill")
        case "sunset":
            return Image(systemName:"sunset")
        default:
            return Image(systemName:"sun.max.fill")
        }
        
    }
    
    var weather: String {
        guard let Weather = weatherResponse?.weather[0].main else {
            return "N/A"
        }
        return String(Weather)
    }
    
    
    func fetchWeather(latitude: Double, longitude: Double) {
        
        WeatherService().getWeather(latitude: latitude, longitude: longitude) { result in
            self.loadingState = .loading
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
