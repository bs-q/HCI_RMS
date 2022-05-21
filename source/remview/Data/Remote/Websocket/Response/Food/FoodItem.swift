//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class FoodItem: Mappable {
    static var FOOD_TYPE_FOOD = 0
    static var FOOD_TYPE_BEILAGE = 1
    var foodType = FOOD_TYPE_FOOD
    var name : String?
    var price : Double?
    var amount : Int?
    func mapping(map: Map) {
        foodType <- map["foodType"]
        name <- map["name"]
        price <- map["price"]
        amount <- map["amount"]
    }
    init() {
        
    }
    required init?(map: Map) {
        
    }
}
