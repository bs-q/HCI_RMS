//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class SocketReportRequest: BaseSocketRequest {

    var fromDate : String?
    var toDate : String?
    var pos : String?
    override func mapping(map: Map) {
        super.mapping(map: map)
        fromDate <- map["fromDate"]
        toDate <- map["toDate"]
        pos <- map["pos"]
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
}
