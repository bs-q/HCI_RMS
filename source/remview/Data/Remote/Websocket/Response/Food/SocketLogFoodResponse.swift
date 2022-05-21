//
//  VerifyTokenResponse.swift
//  agilemark
//
//  Created by _ on 15/12/2021.
//

import Foundation
import ObjectMapper

class SocketLogFoodResponse: Mappable {

    var datas: [LogFoodItem]?
    
    func mapping(map: Map) {
        datas <- map["datas"]
    }
    
    required init?(map: Map) {
        
    }
}
