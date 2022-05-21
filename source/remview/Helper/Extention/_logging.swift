//
//  _logging.swift
//
//  Created by Constantin Cheptea on 21/05/2020.
//
import Foundation

fileprivate let infoMarker = "ℹ️"
fileprivate let debugMarker = "🪲"
fileprivate let warningMarker = "⚠️"
fileprivate let errorMarker = "❌"

func info(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, function: String = #function) {
    log(items, separator: separator, terminator: terminator, marker: infoMarker, file: file, function: function, line: line)
}

func debug(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, function: String = #function) {
    log(items, separator: separator, terminator: terminator, marker: debugMarker, file: file, function: function, line: line)
}

func warning(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, function: String = #function) {
    log(items, separator: separator, terminator: terminator, marker: warningMarker, file: file, function: function, line: line)
}

func error(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, function: String = #function) {
    log(items, separator: separator, terminator: terminator, marker: errorMarker, file: file, function: function, line: line)
}

fileprivate var formatter: DateFormatter = {
    let _formatter = DateFormatter()
    _formatter.dateFormat = "H:m:ss.SSS"
    return _formatter
}()

fileprivate func log(_ items: [Any], separator: String = " ", terminator: String = "\n", marker: String, file: String, function: String, line: Int) {
    let lastSlashIndex = (file.lastIndex(of: "/") ?? String.Index(utf16Offset: 0, in: file))
    let nextIndex = file.index(after: lastSlashIndex)
    let filename = file.suffix(from: nextIndex).replacingOccurrences(of: ".swift", with: "")
    
    let dateString = formatter.string(from: Date())
    
    let prefix = "\(dateString) \(marker) \(filename).\(function):\(line)"
    
    let message = items.map {"\($0)"}.joined(separator: separator)
    print("\(prefix) \(message)", terminator: terminator)
}
