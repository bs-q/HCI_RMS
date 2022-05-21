//
//  Queue.swift
//  remview
//
//  Created by Bui Si Quan on 22/04/2022.
//

import Foundation
struct Queue<T> {
  private var elements: [T] = []

  mutating func enqueue(_ value: T) {
    elements.append(value)
  }

  mutating func dequeue() -> T? {
    guard !elements.isEmpty else {
      return nil
    }
    return elements.removeFirst()
  }
    
    var size: Int {
        return elements.count
    }

  var head: T? {
    return elements.first
  }

  var tail: T? {
    return elements.last
  }
}
