//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class RestaurantSetting: Mappable {
    var numberGroup : String?
    var numberDecimal : String?
    var fromPcs : String? // pos
    var currency : String?
    func mapping(map: Map) {
        numberGroup <- map["numberGroup"]
        numberDecimal <- map["numberDecimal"]
        fromPcs <- map["fromPcs"]
        currency <- map["currency"]
    }
    
    required init?(map: Map) {
        
    }
}
