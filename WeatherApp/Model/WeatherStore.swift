//
//  WeatherStore.swift
//  WeatherApp
//
//  Created by Azura Sakan Taufik on 05/01/22.
//

import Foundation

class WeatherStore: ObservableObject {
  @Published var weather = Weather(lat: 0.0, lon: 0.0, weather: [], base: "", temp: 0.0, feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0, pressure: 0.0, humidity: 0.0, visibility: 0, windSpeed: 0.0, windDeg: 0.0, allClouds: 0, dt: Date(), sysType: 0, sysId: 0, sysCountry: "", sysSunrise: Date(), sysSunset: Date(), timezone: 0, id: 0, name: "", cod: 0)
  
  private static var weatherApiURL = "https://api.openweathermap.org/data/2.5/weather?lat=-6.2146&lon=106.8451&units=metric&appid=2346a7254155ff5fd112d0fbc0fbfc85"
  private var cachedWeather: Weather = Weather(lat: 0.0, lon: 0.0, weather: [], base: "", temp: 0.0, feelsLike: 0.0, tempMin: 0.0, tempMax: 0.0, pressure: 0.0, humidity: 0.0, visibility: 0, windSpeed: 0.0, windDeg: 0.0, allClouds: 0, dt: Date(), sysType: 0, sysId: 0, sysCountry: "", sysSunrise: Date(), sysSunset: Date(), timezone: 0, id: 0, name: "", cod: 0)

  
  func fetchWeather() {
    guard let weatherApiURL = URL(string: Self.weatherApiURL) else {
      return
    }
    
    let request = URLRequest(url: weatherApiURL)
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
      if let error = error {
        print("Fetch Weather Error")
        print(error)
        return
      }
      
      if let data = data {
        DispatchQueue.main.async {
          self.weather = self.parseJSON(data: data)
          self.cachedWeather = self.weather
        }
      }
    })
    
    task.resume()
  }
  
  func parseJSON(data: Data) -> Weather {
    let decoder = JSONDecoder()
    
    do {
      let weather = try decoder.decode(Weather.self, from: data)
      print(weather)
      self.weather = weather
    } catch {
      print("Parse JSON Error")
      print(error)
    }
    
    return weather
  }
}
