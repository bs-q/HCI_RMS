//
//  VerifyTokenRequest.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class VerifyTokenRequest: BaseRequest {
    var email: String?
    var otp : String?
    var otpSecret : String?

    override func toParameters() -> [String: Any] {
        return [
            "email": email as Any,
            "otp": otp as Any,
            "otpSecret": otpSecret as Any
        ]
    }
}
