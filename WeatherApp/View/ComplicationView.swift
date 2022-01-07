//
//  ComplicationView.swift
//  WeatherApp
//
//  Created by Azura on 07/01/22.
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
