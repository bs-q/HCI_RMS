//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class EmployeeRequest: BaseSocketRequest {

    var employee : String?
    var pos : String?
    override func mapping(map: Map) {
        super.mapping(map: map)
        employee <- map["employee"]
        pos <- map["pos"]
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
}
