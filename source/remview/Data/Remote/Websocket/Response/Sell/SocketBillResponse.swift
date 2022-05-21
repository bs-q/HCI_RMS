//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class SocketBillResponse: Mappable {

    var datas: [BillingItemUnit]?
    
    func mapping(map: Map) {
        datas <- map["datas"]
    }
    
    required init?(map: Map) {
        
    }
}
