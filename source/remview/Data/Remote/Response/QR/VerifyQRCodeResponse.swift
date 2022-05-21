//
//  VerifyQRCodeResponse.swift
//  remview
//
//  Created by Bui Si Quan on 23/04/2022.
//

import Foundation
import ObjectMapper


class VerifyQRCodeResponse: Mappable {
    var enabledRemview: String?
    var token: String?
    var posName: String?
    var posId: String?
    var isActive: Bool?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        enabledRemview <- map["enabledRemview"]
        token <- map["token"]
        posName <- map["posName"]
        posId <- map["posId"]
        isActive <- map["isActive"]
    }
    

}
