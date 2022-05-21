//
//  BaseResponseList.swift
//  agilemark
//
//  Created by _ on 24/12/2021.
//

import Foundation
import ObjectMapper

class BaseResponseList<T: Mappable>: Mappable {
    var statusCode : Int?
    var message: String?
    var data: [T]?
    var code: String?
    var error : String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        statusCode <- map["statusCode"]
        message <- map["message"]
        code <- map["code"]
        data <- map["data"]
    }
}
