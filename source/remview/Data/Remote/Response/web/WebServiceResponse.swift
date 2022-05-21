//
//  WebServiceResponse.swift
//  iService
//
//  Created by Bui Si Quan on 10/12/2021.
//

import Foundation
import ObjectMapper
class WebServiceResponse: Mappable {
    var serviceId : String?
    required init?(map: Map) {

    }
    init() {
        
    }

    func mapping(map: Map) {
        serviceId <- map["serviceId"]
    }
}
