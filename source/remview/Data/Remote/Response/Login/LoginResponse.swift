//
//  LoginResponse.swift
//  iService
//
//  Created by Admin on 10/8/21.
//

import Foundation
import ObjectMapper

class LoginResponse: Mappable {

    var otpSecret: String?
   
    
    func mapping(map: Map) {
        otpSecret <- map["otpSecret"]
    }
    
    required init?(map: Map) {
        
    }
}
