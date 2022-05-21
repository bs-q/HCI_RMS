//
//  BaseRequest.swift
//  iService
//
//  Created by Admin on 9/15/21.
//

import Foundation
import Resolver
import Alamofire
import ObjectMapper

class Platform: NSObject {
    static let platform  = 1;
}

class BaseRequest {
    var platform: Int? = Platform.platform

    func toParameters() -> [String: Any] {
        return [
            "platform": platform as Any
        ]
    }
}
