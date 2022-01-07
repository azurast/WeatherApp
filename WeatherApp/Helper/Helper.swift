//
//  Helper.swift
//  WeatherApp
//
//  Created by Azura on 06/01/22.
//

import Foundation

func dateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yy HH:mm a"
    return formatter
}

func timeFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}

extension Date {
  
  var toDateString : String { dateFormatter().string(from: self) }
  var toTimeString : String { timeFormatter().string(from: self) }
}
