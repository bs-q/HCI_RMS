//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class SocketLogFoodRequest: BaseSocketRequest {

    var date : String?
    var fromPc : String?
    override func mapping(map: Map) {
        super.mapping(map: map)
        fromPc <- map["fromPc"]
        date <- map["date"]
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
}
