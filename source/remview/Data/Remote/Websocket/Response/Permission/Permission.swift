//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class Permission: Mappable {
  
    var name : String?;
    var password : String?;
    var role : Int?;
    var ibutton : String?;
    var nfc : String?;
    
    func mapping(map: Map) {
        name <- map["name"]
        password <- map["password"]
        role <- map["role"]
        ibutton <- map["ibutton"]
        nfc <- map["nfc"]
    }
    init() {
        
    }
    required init?(map: Map) {
        
    }
}
