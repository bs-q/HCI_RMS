//
//  ProfileResponse.swift
//  iService
//
//  Created by Admin on 10/8/21.
//

import Foundation
import ObjectMapper


class Message: Mappable {
    class MessageRequest : Mappable {
        func mapping(map: Map) {
            platform <- map["platform"]
            cmd <- map["cmd"]
            data <- map["data"]
            screen <- map["screen"]
            msg <- map["msg"]
            token <- map["token"]
        }
        
        var platform: Int = 1
        var cmd: String?
        var data: BaseSocketRequest?
        var screen: String?
        var msg : String?
        var token : String?
        required init?(map: Map) {
            
        }
        init(message:Message){
            self.platform = message.platform
            self.cmd = message.cmd
            self.screen = message.screen
            self.token = message.token
            self.data = message.requestData
        }
    }
    var platform: Int = 1
    var cmd: String?
    var data: Any?
    var requestData : BaseSocketRequest?
    var screen: String?
    var responseCode: Int?
    var msg : String?
    var token : String?
    
    required init?(map: Map) {
        
    }
    init() {
        
    }
    
    func generateRequest(message:Message)->String {
        return MessageRequest(message: message).toJSONString()!
    }
    
    func mapping(map: Map) {
        platform <- map["platform"]
        cmd <- map["cmd"]
        data <- map["data"]
        screen <- map["screen"]
        responseCode <- map["responseCode"]
        msg <- map["msg"]
        token <- map["token"]

    }
    

}
