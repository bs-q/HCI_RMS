//
//  BaseResponse.swift
//  iService
//
//  Created by Admin on 9/15/21.
//

import Foundation
import ObjectMapper

class ResponseCode: NSObject {
    static let CODE_SUCCESS: Int = 200;
}

class BaseResponse<T: Mappable>: Mappable {
    var result : Bool?
    var message: String?
    var data: T?
    var code: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        message <- map["message"]
        code <- map["code"]
        data <- map["data"]
    }
}
