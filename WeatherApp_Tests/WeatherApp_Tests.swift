//
//  WeatherApp_Tests.swift
//  WeatherApp_Tests
//
//  Created by Azura on 07/01/22.
//

import XCTest
@testable import WeatherApp

class WeatherApp_Tests: XCTestCase {

  override func setUpWithError() throws {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_WeatherViewModel_canParseJSON_shouldBeParsed() {
    let jsonResponse = """
      {
        "coord": {
          "lon": 106.8451,
          "lat": -6.2146
        },
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03d"
          }
        ],
        "base": "stations",
        "main": {
          "temp": 31.12,
          "feels_like": 36.73,
          "temp_min": 31.05,
          "temp_max": 32.51,
          "pressure": 1012,
          "humidity": 66
        },
        "visibility": 6000,
        "wind": {
          "speed": 2.57,
          "deg": 160
        },
        "clouds": {
          "all": 40
        },
        "dt": 1641525317,
        "sys": {
          "type": 1,
          "id": 9383,
          "country": "ID",
          "sunrise": 1641509075,
          "sunset": 1641553945
        },
        "timezone": 25200,
        "id": 1642911,
        "name": "Jakarta",
        "cod": 200
      }
    """
    if let jsonData = jsonResponse.data(using: .utf8) {
      let decoder = JSONDecoder()
      do {
        let weather = try decoder.decode(Weather.self, from: jsonData)
        XCTAssertEqual(31.12, weather.temp)
        XCTAssertEqual("Jakarta", weather.name)
      } catch {
        print("error")
      }
    }
  }
}
