//
//  JSONHelper.swift
//  iService
//
//  Created by Admin on 9/16/21.
//

import Foundation
import ObjectMapper

class JSONHelper: NSObject {
    static func toJson<T: Mappable>(baseRequest: T) -> String {
        var result = Mapper<T>().toJSONString(baseRequest, prettyPrint: false) ?? "{}"
        result = result.replacingOccurrences(of: "\\", with: "");
        return result;
    }
}
