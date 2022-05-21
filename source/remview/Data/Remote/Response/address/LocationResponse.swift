//
//  AddressResponse.swift
//  iService
//
//  Created by Bui Si Quan on 08/12/2021.
//

import Foundation

import ObjectMapper
class LocationResponse: Mappable {
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var id : Int64?

    required init?(map: Map) {

    }
    init() {
        
    }

    func mapping(map: Map) {
        address <- map["address"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        id <- map["id"]
    }
}
