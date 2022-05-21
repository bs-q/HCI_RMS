//
// Created by _ on 05/11/2021.
//

import Foundation
import ObjectMapper

public class DateFormatTransform: TransformType {
    
    public typealias Object = Date
    public typealias JSON = String

    var dateFormat = DateFormatter()

    convenience init(_ format: String) {
        self.init()
        self.dateFormat.dateFormat = format
    }

    open func transformFromJSON(_ value: Any?) -> Date? {
    
        if let timeStr = value as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return dateFormatter.date(from: timeStr)
        }

        return nil
    }

    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            return date.convertDateToString(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        }
        return nil
    }
}
