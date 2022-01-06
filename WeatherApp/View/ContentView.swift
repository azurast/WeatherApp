//
//  ContentView.swift
//  WeatherApp
//
//  Created by Azura Sakan Taufik on 05/01/22.
//

import SwiftUI

struct ComplicationView: View {
  var symbolName: String
  var titleText: String
  var bodyText: String
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16, style: .continuous).fill(.white).opacity(0.2)
      VStack {
        Image(systemName: symbolName)
        Text(titleText).fontWeight(.bold)
        Text(bodyText)
      }
    }.frame(width: 110, height: 110)
  }
}

struct ContentView: View {
  @ObservedObject var weatherViewModel: WeatherViewModel = WeatherViewModel()
  
  // Todo:jgn di view, dont use impicitly unwrapping
  var calendar = Calendar.current
  
    var body: some View {
      ScrollRefreshable(title: "Pull down to refresh", tintColor: .purple, content: {
        VStack(alignment: .center, spacing: 8) {
          // Make full-width
          HStack {
            Spacer()
          }
          Text("\(weatherViewModel.formattedWeather.location)").font(.title).fontWeight(.bold).multilineTextAlignment(.center)
          Text("Updated at : \(weatherViewModel.formattedWeather.updatedAt)").multilineTextAlignment(.center).padding(.horizontal)
          Spacer()
          Text(weatherViewModel.formattedWeather.condition).font(.title3)
          Text("\(weatherViewModel.formattedWeather.currentTemp) °C").fontWeight(.bold).font(.system(size: 58.0))
          HStack(alignment: .center, spacing: 8) {
            Text("Min Temp: \(weatherViewModel.formattedWeather.minTemp)")
            Text("Max Temp: \(weatherViewModel.formattedWeather.maxTemp)")
          }
          Spacer().frame(height: 200, alignment: .center)
          HStack(alignment: .center, spacing: 8) {
            ComplicationView(symbolName: "sunrise", titleText: "Sunrise", bodyText: weatherViewModel.formattedWeather.sunriseTime)
            ComplicationView(symbolName: "sunset", titleText: "Sunset", bodyText: weatherViewModel.formattedWeather.sunsetTime)
            ComplicationView(symbolName: "wind", titleText: "Wind", bodyText: weatherViewModel.formattedWeather.windSpeed)
          }
          HStack(alignment: .center, spacing: 8) {
            ComplicationView(symbolName: "rectangle.compress.vertical", titleText: "Pressure", bodyText: weatherViewModel.formattedWeather.pressureUnit)
            ComplicationView(symbolName: "humidity", titleText: "Humidity", bodyText: weatherViewModel.formattedWeather.humidityLevel)
            ComplicationView(symbolName: "info.circle", titleText: "Created By", bodyText: "Azura")
          }
        }.padding(.all)
        .foregroundColor(.white)
        .onAppear() {
          self.weatherViewModel.fetchWeather()
        }}) {
      self.weatherViewModel.fetchWeather()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice("iPhone 12")
    }
}
