//
//  LoginRequest.swift
//  iService
//
//  Created by Admin on 10/6/21.
//

import UIKit
import ObjectMapper

class LoginRequest: BaseRequest {
    var email: String?
   
    
    override func toParameters() -> [String: Any] {
        return [
            "email": email as Any,
        ]
    }
}
