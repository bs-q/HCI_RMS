//
//  ProfileResponse.swift
//  iService
//
//  Created by Admin on 10/8/21.
//

import Foundation
import ObjectMapper


class ProfileResponse: Mappable {
    var id: String?
    var name: String?
    var avatarUrl: String?
    var username: String?
    var email: String?
    var focusAreaId : String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatarUrl <- map["avatarUrl"]
        username <- map["username"]
        email <- map["email"]
        focusAreaId <- map["focusAreaId"]
    }
    

}
