//
//  WeatherStore.swift
//  WeatherApp
//
//  Created by Azura Sakan Taufik on 05/01/22.
//

import Foundation

struct WeatherFormat {
  var location: String = ""
  var updatedAt: String = ""
  var condition: String = ""
  var currentTemp: String = ""
  var minTemp: String = ""
  var maxTemp: String = ""
  var sunriseTime: String = ""
  var sunsetTime: String = ""
  var windSpeed: String = ""
  var pressureUnit: String = ""
  var humidityLevel: String = ""
}

class WeatherViewModel: ObservableObject {
  @Published var weather = Weather(lat: 0.0, lon: 0.0, weather: [], base: "", temp: 0.0, feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0, pressure: 0.0, humidity: 0.0, visibility: 0, windSpeed: 0.0, windDeg: 0.0, allClouds: 0, dt: Date(), sysType: 0, sysId: 0, sysCountry: "", sysSunrise: Date(), sysSunset: Date(), timezone: 0, id: 0, name: "", cod: 0)
  @Published var formattedWeather: WeatherFormat = WeatherFormat()
  private static var weatherApiURL = "https://api.openweathermap.org/data/2.5/weather?lat=-6.2146&lon=106.8451&units=metric&appid=2346a7254155ff5fd112d0fbc0fbfc85"
  private let allowedDiskSize = 100 * 1024  * 1024
  private var cache: URLCache {
    return URLCache(memoryCapacity: 0, diskCapacity: allowedDiskSize)
  }
  typealias cacheCompletionHandler = (Result<Data, Error>) -> ()
 
  func configureURLSession() -> URLSession {
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .returnCacheDataElseLoad
    config.urlCache = cache
    return URLSession(configuration: config)
  }
  
  // MARK: Fetch Weather
  func fetchWeather(completionHandler: @escaping cacheCompletionHandler) {
    // URL
    guard let weatherApiURL = URL(string: Self.weatherApiURL) else { return }
    
    // Request
    let request = URLRequest(url: weatherApiURL)
    
    // Get from Cache first so UI is not empty
    if let cachedData = self.cache.cachedResponse(for: request) {
      DispatchQueue.main.async {
        self.weather = self.parseJSON(data: cachedData.data)
        self.formatWeather()
      }
      completionHandler(.success(cachedData.data))
    }
    
    // Session & Task
    let task = configureURLSession().dataTask(with: request) { (data, response, error) -> Void in
      if let error = error {
        completionHandler(.failure(error))
      }
      
      if let data = data, let response = response {
        let cachedData = CachedURLResponse(response: response, data: data)
        self.cache.storeCachedResponse(cachedData, for: request)
        DispatchQueue.main.async {
          self.weather = self.parseJSON(data: data)
          self.formatWeather()
        }
        completionHandler(.success(data))
      }
    }
    task.resume()
  }
   
  // MARK: Parse JSON Data
  func parseJSON(data: Data) -> Weather {
    let decoder = JSONDecoder()
    
    do {
      let weather = try decoder.decode(Weather.self, from: data)
      self.weather = weather
    } catch {
      print(error)
    }
    return weather
  }
  
  // MARK: Format the weather for UI consumption
  func formatWeather() {
    formattedWeather.location = self.weather.name! + ", " + self.weather.sysCountry!
    formattedWeather.updatedAt = Date().toDateString
    if let condition = self.weather.weather?.first?.main {
      formattedWeather.condition = condition
    }
    formattedWeather.currentTemp = String(format: "%.0f", self.weather.temp!)
    formattedWeather.minTemp = String(format: "%.0f", self.weather.tempMin!)
    formattedWeather.maxTemp = String(format: "%.0f", self.weather.tempMax!)
    formattedWeather.sunriseTime = self.weather.sysSunrise!.toTimeString
    formattedWeather.sunsetTime = self.weather.sysSunset!.toTimeString
    formattedWeather.windSpeed = String(format: "%.1f", self.weather.windSpeed!)
    formattedWeather.pressureUnit = String(format: "%.0f", self.weather.pressure!)
    formattedWeather.humidityLevel = String(format: "%.0f", self.weather.humidity!)
  }
}
