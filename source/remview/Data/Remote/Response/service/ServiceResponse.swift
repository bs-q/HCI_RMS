//
//  ServiceResponse.swift
//  iService
//
//  Created by Bui Si Quan on 10/12/2021.
//

import Foundation
import ObjectMapper
class ServiceResponse: Mappable {
    var id : Int64?
    var serviceName : String?
    var servicePrice : Int?
    var promotionCode : String?

    // not map field
    var selected : Bool = false // this field use in choose screen
    var quantity : Int  = 1 // this field use in book screen

    required init?(map: Map) {

    }
    init() {
    }

    func mapping(map: Map) {
        id <- map["id"]
        serviceName <- map["serviceName"]
        servicePrice <- map["servicePrice"]
        promotionCode <- map["promotionCode"]
    }
    
}
