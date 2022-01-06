//
//  ScrollRefreshable.swift
//  WeatherApp
//
//  Created by Azura on 06/01/22.
//

import SwiftUI

struct ScrollRefreshable<Content: View>: View {
  var content: Content
  var onRefresh: () async -> ()
  
  init(title: String, tintColor: Color, @ViewBuilder content: @escaping () -> Content, onRefresh: @escaping () async -> ()) {
    self.content = content()
    self.onRefresh = onRefresh
    
    UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    UIRefreshControl.appearance().tintColor = UIColor(tintColor)
  }
  
  var body: some View {
    List {
      content
        .listRowSeparatorTint(.clear)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    .listStyle(.plain)
    .background(LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    .refreshable {
      await onRefresh()
    }
  }
}
