//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class VerifyTokenResponse: Mappable {

    var enabledRemview: String?
    var token: String?

    
    func mapping(map: Map) {
        enabledRemview <- map["enabledRemview"]
        token <- map["token"]
    }
    
    required init?(map: Map) {
        
    }
}
