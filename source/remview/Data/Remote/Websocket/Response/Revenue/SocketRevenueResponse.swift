//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class SocketRevenueResponse: Mappable {

    var dataReport: [DayEventUnit]?
    func mapping(map: Map) {
        dataReport <- map["dataReport"]
    }
    
    required init?(map: Map) {
        
    }
}
