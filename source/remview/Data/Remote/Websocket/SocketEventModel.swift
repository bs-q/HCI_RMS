//
//  SocketEventModel.swift
//  remview
//
//  Created by Bui Si Quan on 22/04/2022.
//

import Foundation
import ObjectMapper
class SocketEventModel : Mappable{
    enum Event {
        case online
        case offline
        case error
        case message
    }
    required init?(map: Map) {
        
    }
    var event : Event?
    var message : Message?
    init(message : Message?) {
        self.message = message
    }
    func mapping(map: Map) {
        event <- map["event"]
        message <- map["message"]
    }
}
