//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class LogFoodItem: Mappable {
    var  date : String?
    var  employee : String?
    var  forEmployee : String?
    var  tableName : String?
    var  foodName : String?
    var  quantity : Double?
    var  price : Int?
    var  totalMoney : Int?
    var  printer : String?
    var  art : String?
    var  fromPC : String?
    func mapping(map: Map) {
        date <- map["date"]
        employee <- map["employee"]
        forEmployee <- map["forEmployee"]
        tableName <- map["tableName"]
        foodName <- map["foodName"]
        quantity <- map["quantity"]
        price <- map["price"]
        totalMoney <- map["totalMoney"]
        printer <- map["printer"]
        fromPC <- map["fromPC"]
        art <- map["art"]

    }
    func parseDate()->Date{
        return date!.convertToDate(dateFormat: "yyyy.MM.dd HH:mm:ss")
    }
    init() {
        
    }
    required init?(map: Map) {
        
    }
}
