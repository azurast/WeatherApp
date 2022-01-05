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
  @ObservedObject var weatherStore: WeatherStore = WeatherStore()
  
  // Todo:jgn di view, dont use impicitly unwrapping
  var calendar = Calendar.current
  
    var body: some View {
      ZStack {
        LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        VStack(alignment: .center, spacing: 8) {
          Text("\(weatherStore.weather.name! + ", " + weatherStore.weather.sysCountry!)").font(.title).fontWeight(.bold)
          Text("Updated at : \(Date())").multilineTextAlignment(.center).padding(.horizontal)
          Spacer()
          Text(weatherStore.weather.weather?.first?.main ?? "Unavailable").font(.title3)
          Text("\(weatherStore.weather.temp!) °C").fontWeight(.bold).font(.system(size: 58.0))
          HStack(alignment: .center, spacing: 8) {
            Text("Min Temp:\(weatherStore.weather.tempMin!)")
            Text("Max Temp:\(weatherStore.weather.tempMax!)")
          }.padding(.all)
          Spacer()
          HStack(alignment: .center, spacing: 8) {
            ComplicationView(symbolName: "sunrise", titleText: "Sunrise", bodyText: String(describing: calendar.component(.hour, from: weatherStore.weather.sysSunrise!)))
            ComplicationView(symbolName: "sunset", titleText: "Sunset", bodyText: String(describing: calendar.component(.hour, from: weatherStore.weather.sysSunset!)))
            ComplicationView(symbolName: "wind", titleText: "Wind", bodyText: String(describing: weatherStore.weather.windSpeed!))
          }.padding(.all)
          HStack(alignment: .center, spacing: 8) {
            ComplicationView(symbolName: "rectangle.compress.vertical", titleText: "Pressure", bodyText: String(describing: weatherStore.weather.pressure!))
            ComplicationView(symbolName: "humidity", titleText: "Humidity", bodyText: String(describing: weatherStore.weather.humidity!))
            ComplicationView(symbolName: "info.circle", titleText: "Created By", bodyText: "Azura")
          }
        }.padding(.all)
          .foregroundColor(.white)
      }
      .onAppear() {
        self.weatherStore.fetchWeather()
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
