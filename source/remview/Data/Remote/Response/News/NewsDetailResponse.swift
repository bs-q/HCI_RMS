//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class NewsDetailResponse: Mappable {

    var id : Int64?
    var title : String?
    
    func mapping(map: Map) {
        title <- map["title"]
        id <- map["id"]
    }
    
    required init?(map: Map) {
        
    }
}
