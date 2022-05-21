//
//  VerifyQRCodeRequest.swift
//  remview
//
//  Created by Bui Si Quan on 23/04/2022.
//

import Foundation

class VerifyQRCodeRequest: BaseRequest {
    var qrCode: String?
    var deviceId: String?

    
    override func toParameters() -> [String: Any] {
        return [
            "qrCode": qrCode as Any,
            "deviceId": deviceId as Any,
            "platform" : platform as Any,
        ]
    }
}
