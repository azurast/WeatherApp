//
//  Weather.swift
//  WeatherApp
//
//  Created by Azura Sakan Taufik on 05/01/22.
//

import Foundation

struct WeatherCondition: Codable {
  var id: Int
  var main: String
  var description: String
  var icon: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case main
    case description
    case icon
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    main = try container.decode(String.self, forKey: .main)
    description = try container.decode(String.self, forKey: .description)
    icon = try container.decode(String.self, forKey: .icon)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.id, forKey: .id)
    try container.encode(self.main, forKey: .main)
    try container.encode(self.description, forKey: .description)
    try container.encode(self.icon, forKey: .icon)
  }
}

struct Weather: Identifiable {
  var lat: Double?
  var lon: Double?
  var weather: [WeatherCondition]?
  var base: String?
  var temp: Double?
  var feelsLike: Double?
  var tempMin: Double?
  var tempMax: Double?
  var pressure: Double?
  var humidity: Double?
  var visibility: Int?
  var windSpeed: Double?
  var windDeg: Double?
//  let windGust: Double?
  var allClouds: Int?
  var dt: Date?
  var sysType: Int?
  var sysId: Int?
  var sysCountry: String?
  var sysSunrise: Date?
  var sysSunset: Date?
  var timezone: Int?
  var id: Int
  var name: String?
  var cod: Int?
  
  init(lat: Double? = nil, lon: Double? = nil, weather: [WeatherCondition]? = nil, base: String? = nil, temp: Double? = nil, feelsLike: Double? = nil, tempMin: Double? = nil, tempMax: Double? = nil, pressure: Double? = nil, humidity: Double? = nil, visibility: Int? = nil, windSpeed: Double? = nil, windDeg: Double? = nil, allClouds: Int? = nil, dt: Date? = nil, sysType: Int? = nil, sysId: Int? = nil, sysCountry: String? = nil, sysSunrise: Date? = nil, sysSunset: Date? = nil, timezone: Int? = nil, id: Int, name: String? = nil, cod: Int? = nil) {
    self.lat = lat
    self.lon = lon
    self.weather = weather
    self.base = base
    self.temp = temp
    self.feelsLike = feelsLike
    self.tempMin = tempMin
    self.tempMax = tempMax
    self.pressure = pressure
    self.humidity = humidity
    self.visibility = visibility
    self.windSpeed = windSpeed
    self.windDeg = windDeg
//    self.windGust = windGust
    self.allClouds = allClouds
    self.dt = dt
    self.sysType = sysType
    self.sysId = sysId
    self.sysCountry = sysCountry
    self.sysSunrise = sysSunrise
    self.sysSunset = sysSunset
    self.timezone = timezone
    self.id = id
    self.name = name
    self.cod = cod
  }
}
  
extension Weather: Codable {
  enum CodingKeys: String, CodingKey {
    case coord
    case weather = "weather"
    case base
    case main
    case visibility
    case wind
    case clouds
    case dt
    case sys
    case timezone
    case id
    case name
    case cod
  }
  
  enum CoordinateKeys: String, CodingKey {
    case lat
    case lon
  }
  
  enum MainKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure
    case humidity
  }
  
  enum WindKeys: String, CodingKey {
    case windSpeed = "speed"
    case windDeg = "deg"
//    case windGust = "gust"
  }
  
  enum CloudsKeys: String, CodingKey {
    case allClouds = "all"
  }
  
  enum SysKeys: String, CodingKey {
    case sysType = "type"
    case sysId = "id"
    case sysCountry = "country"
    case sysSunrise = "sunrise"
    case sysSunset = "sunset"
  }
  
  // Encodable
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    // Others
    try container.encode(weather, forKey: .weather)
    try container.encode(base, forKey: .base)
    try container.encode(visibility, forKey: .visibility)
    try container.encode(dt, forKey: .dt)
    try container.encode(timezone, forKey: .timezone)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(cod, forKey: .cod)
    
    // Coordinate
    var coordinate = container.nestedContainer(keyedBy: CoordinateKeys.self, forKey: .coord)
    try coordinate.encode(lat, forKey: .lat)
    try coordinate.encode(lon, forKey: .lon)
    
    // Main
    var main = container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
    try main.encode(temp, forKey: .temp)
    try main.encode(humidity, forKey: .humidity)
    try main.encode(feelsLike, forKey: .feelsLike)
    try main.encode(pressure, forKey: .pressure)
    try main.encode(tempMin, forKey: .tempMin)
    try main.encode(tempMax, forKey: .tempMax)
    
    // Wind
    var wind = container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
    try wind.encode(windSpeed, forKey: .windSpeed)
    try wind.encode(windDeg, forKey: .windDeg)
//    try wind.encode(windGu, forKey: .windGust)
    
    // Clouds
    var clouds = container.nestedContainer(keyedBy: CloudsKeys.self, forKey: .clouds)
    try clouds.encode(allClouds, forKey: .allClouds)
    
    // Sys
    var sys = container.nestedContainer(keyedBy: SysKeys.self, forKey: .sys)
    try sys.encode(sysType, forKey: .sysType)
    try sys.encode(sysId, forKey: .sysId)
    try sys.encode(sysCountry, forKey: .sysCountry)
    try sys.encode(sysSunrise, forKey: .sysSunrise)
    try sys.encode(sysSunset, forKey: .sysSunset)
  }
  
  // Decodable
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    // Coordinates
    let coord = try container.nestedContainer(keyedBy: CoordinateKeys.self, forKey: .coord)
    lat = try coord.decode(Double.self, forKey: .lat)
    lon = try coord.decode(Double.self, forKey: .lon)
    
    // Weather
    weather = try container.decode([WeatherCondition].self, forKey: .weather)
    
    // Base
    base = try container.decode(String.self, forKey: .base)
    
    // Main
    let main = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
    temp = try main.decode(Double.self, forKey: .temp)
    feelsLike = try main.decode(Double.self, forKey: .feelsLike)
    tempMax = try main.decode(Double.self, forKey: .tempMax)
    tempMin = try main.decode(Double.self, forKey: .tempMin)
    pressure = try main.decode(Double.self, forKey: .pressure)
    humidity = try main.decode(Double.self, forKey: .humidity)
    
    // Visibility
    visibility = try container.decode(Int.self, forKey: .visibility)
    
    // Wind
    let wind = try container.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
    windSpeed = try wind.decode(Double.self, forKey: .windSpeed)
    windDeg = try wind.decode(Double.self, forKey: .windDeg)
//    windGust = try wind.decode(Double.self, forKey: .windGust)
    
    // Clouds
    let clouds = try container.nestedContainer(keyedBy: CloudsKeys.self, forKey: .clouds)
    allClouds = try clouds.decode(Int.self, forKey: .allClouds)
    
    // Dt
    dt = try container.decode(Date.self, forKey: .dt)
    
    // Sys
    let sys = try container.nestedContainer(keyedBy: SysKeys.self, forKey: .sys)
    sysType = try sys.decode(Int.self, forKey: .sysType)
    sysId = try sys.decode(Int.self, forKey: .sysId)
    sysCountry = try sys.decode(String.self, forKey: .sysCountry)
    sysSunrise = try sys.decode(Date.self, forKey: .sysSunrise)
    sysSunset = try sys.decode(Date.self, forKey: .sysSunset)
    
    // Others
    timezone = try container.decode(Int.self, forKey: .timezone)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    cod = try container.decode(Int.self, forKey: .cod)
  }
}
