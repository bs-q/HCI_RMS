//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class UpdatePermissionRequest: BaseSocketRequest {

    var oldName : String?
    var employee : Permission?
    override func mapping(map: Map) {
        super.mapping(map: map)
        oldName <- map["oldName"]
        employee <- map["employee"]
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
 
}
