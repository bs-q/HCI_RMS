//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class DayEventUnit: Mappable {

    var name: String?
    var totalMoney: Double?
    
    func mapping(map: Map) {
        name <- map["name"]
        totalMoney <- map["Summe"]
    }
    
    required init?(map: Map) {
        
    }
}
