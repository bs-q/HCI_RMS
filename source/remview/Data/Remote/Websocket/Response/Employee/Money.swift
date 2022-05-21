//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class Money: Mappable {
  
    var name : String?
    var money : Int?
    func mapping(map: Map) {
        name <- map["name"]
        money <- map["money"]
    }
    init() {
        
    }
    required init?(map: Map) {
        
    }
}
