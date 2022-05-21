//
//  SavedAddressResponse.swift
//  iService
//
//  Created by Bui Si Quan on 08/12/2021.
//

import Foundation
import ObjectMapper
class SavedAddressResponse: Mappable {
    var data: [LocationResponse]?
    

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        data <- map["data"]
    }
}
