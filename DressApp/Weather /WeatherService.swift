
import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class WeatherService {
    
    func getWeather(latitude: Double,longitude: Double ,completion: @escaping (Result<WeatherResponse?, NetworkError>) -> Void) {
        
        guard let url = URL.urlForWeatherFor(latitude,longitude) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
        
    }
    
}
