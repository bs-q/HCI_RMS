//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class EmployeeResponse: Mappable {
  
    var employees : [EmployeeObject]?
    func mapping(map: Map) {
        employees <- map["employees"]
    }
    init() {
        
    }
    required init?(map: Map) {
        
    }
}
