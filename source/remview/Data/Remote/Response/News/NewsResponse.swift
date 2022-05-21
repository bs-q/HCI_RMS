//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class NewsResponse: Mappable {

    var title: String?
    var avatar: String?
    var id : Int64?
    
    func mapping(map: Map) {
        title <- map["title"]
        avatar <- map["avatar"]
        id <- map["id"]
    }
    
    required init?(map: Map) {
        
    }
}
