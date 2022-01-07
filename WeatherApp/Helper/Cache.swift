//
//  Cache.swift
//  WeatherApp
//
//  Created by Azura on 07/01/22.
//

import Foundation

class Wrapper<T>: NSObject {
  let value: T
  
  init(_ _struct: T) {
    value = _struct
  }
}

class Cache: NSCache<NSString, Wrapper<Weather>> {
  static let shared = Cache()
  private override init() {}
  
  func insertCache(_ weather: Weather, for key: Int) {
    let key = NSString(format: "%d", key)
    let wrapper = Wrapper(weather)
    self.setObject(wrapper, forKey: key)
  }
}

//final class Cache<Key: Hashable, Value> {
//  private let wrapped = NSCache<WrappedKey, Entry>()
//
//  func insert(_ value: Value, forKey key: Key) {
//    let entry = Entry(value: value)
//    wrapped.setObject(entry, forKey: WrappedKey(key))
//  }
//
//  func value(forKey key: Key) -> Value? {
//    let entry = wrapped.object(forKey: WrappedKey(key))
//    return entry?.value
//  }
//
//  func removeValue(forKey key: Key) {
//    wrapped.removeObject(forKey: WrappedKey(key))
//  }
//}
//
//private extension Cache {
//  final class WrappedKey: NSObject {
//    let key: Key
//
//    init(_ key: Key) {
//      self.key = key
//
//    }
//
//    override var hash: Int {
//      return key.hashValue
//
//    }
//
//    override func isEqual(_ object: Any?) -> Bool {
//      guard let value = object as? WrappedKey else {
//        return false
//      }
//
//      return value.key == key
//    }
//  }
//}
//
//private extension Cache {
//  final class Entry {
//    let value = Value
//
//    init(value: Value) {
//      self.value = Value
//    }
//  }
//}
//
//extension Cache {
//  subscript(key: Key) -> Value {
//    get { return value(forKey: key) }
//    set {
//      guard let value = newValue else {
//        removeValue(forKey: key)
//        return
//      }
//      insert(value, forKey: key)
//    }
//  }
//}
