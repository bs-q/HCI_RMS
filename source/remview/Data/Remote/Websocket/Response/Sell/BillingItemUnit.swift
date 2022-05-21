//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class BillingItemUnit: Mappable {
    var date : String?
    var billNumber : Int?
    var employee : String?
    var tableName : String?
    var totalMoney : Int?
    var paymentMethod : String?
    var inOrOut : String?
    var percent : Double?
    var isBillingDelete : String?
    var fromPC : String?
    var monAn : String?
    func mapping(map: Map) {
        date <- map["date"]
        billNumber <- map["billNumber"]
        employee <- map["employee"]
        tableName <- map["tableName"]
        totalMoney <- map["totalMoney"]
        paymentMethod <- map["paymentMethod"]
        inOrOut <- map["inOrOut"]
        percent <- map["percent"]
        isBillingDelete <- map["isBillingDelete"]
        fromPC <- map["fromPC"]
        monAn <- map["monAn"]
       
    }
    
    required init?(map: Map) {
        
    }
}
