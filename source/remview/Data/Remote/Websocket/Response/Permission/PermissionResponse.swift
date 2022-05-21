//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class PermissionResponse: Mappable {
  
    var datas : [Permission]?
    func mapping(map: Map) {
        datas <- map["datas"]
    }
    init() {
        
    }
    required init?(map: Map) {
        
    }
}
