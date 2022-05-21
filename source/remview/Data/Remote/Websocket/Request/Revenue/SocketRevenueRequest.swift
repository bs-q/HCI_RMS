//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class SocketRevenueRequest: BaseSocketRequest {

    static var REPORT_KIND_REVENUE_DAY = 13
    var kind : Int?
    override func mapping(map: Map) {
        super.mapping(map: map)
        kind <- map["kind"]
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
}
