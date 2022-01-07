//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Azura on 06/01/22.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
  let monitor = NWPathMonitor()
  let queue = DispatchQueue(label: "NetworkManager")
  @Published var isDisconnectedToNetwork = true
  
  var connectionStatus: Bool {
    if isDisconnectedToNetwork {
      return true
    } else {
      return false
    }
  }
  
  init() {
    monitor.pathUpdateHandler = { path in
      DispatchQueue.main.async {
        self.isDisconnectedToNetwork = path.status == .unsatisfied
      }
    }
    monitor.start(queue: queue)
  }
}
