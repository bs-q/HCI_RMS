//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class EmployeeObject: Mappable {
  
    var employeeName : String?
    var money : [Money]?
    func mapping(map: Map) {
        employeeName <- map["employeeName"]
        money <- map["money"]
    }
    init() {
        
    }
    required init?(map: Map) {
        
    }
}
