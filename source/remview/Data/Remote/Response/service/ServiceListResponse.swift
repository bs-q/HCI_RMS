//
//  ServiceListResponse.swift
//  iService
//
//  Created by Bui Si Quan on 11/12/2021.
//

import Foundation
import ObjectMapper
class ServiceListResponse: Mappable {
    var serviceList : [ServiceResponse]?
   

    required init?(map: Map) {

    }
    init() {
    }

    func mapping(map: Map) {
        serviceList <- map["data"]
    }
}
