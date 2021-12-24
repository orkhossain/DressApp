import Foundation


extension URL {

    static func urlForWeatherFor(_ latitude: Double, _ longitude: Double) -> URL? {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=88e5d659b91bc187aed5734638edbb2d") else {
            return nil
        }
        
        return url
        
    }
    
}
