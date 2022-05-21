//
//  ErrorCode.swift
//  iService
//
//  Created by Admin on 10/7/21.
//

import Foundation

struct ApiError {
    
    var networkCode: Int
    var msgError: String
    var apiResponseCode: String
    var apiResponseSubCode: String?
    
    
    
    init(networkCode: Int, msgError: String, apiResponseCode: String, apiResponseSubCode: String?) {
        self.networkCode = networkCode
        self.msgError = msgError
        self.apiResponseCode = apiResponseCode
        self.apiResponseSubCode = apiResponseSubCode
    }
}

struct InternetError {
    var msgError: String

    
    init(msgError: String) {
        self.msgError = msgError
    }
}
