//
//  ApplicationEntity.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import GRDB
import UIKit
import ObjectMapper


struct ApplicationEntity: Codable, Equatable {
    var id: Int64?
    var image: String?
    var name: String?
    var email: String?
    var lastScan: Int64?
    var selected : Bool?
    var isDummy : Bool?
    var applicationName : String?
    var securityInformation : String?
    var exposeLevel = 0
    var suggestNumber = 0
    var userId : Int64?
    
    enum applicationType : String {
        case  instagram  = "instagram"
        case  twitter = "twitter"
        case  linkedIn = "linkedIn"
        case  facebook = "facebook"
        case  dummy = "addSocial"
    }
    
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let image = Column(CodingKeys.image)
        static let name = Column(CodingKeys.name)
        static let email = Column(CodingKeys.email)
        static let lastScan = Column(CodingKeys.lastScan)
        static let selected = Column(CodingKeys.selected)
        static let applicationName = Column(CodingKeys.applicationName)
        static let securityInformation = Column(CodingKeys.securityInformation)
        static let exposeLevel = Column(CodingKeys.exposeLevel)
        static let suggestNumber = Column(CodingKeys.suggestNumber)
        static let userId = Column(CodingKeys.userId)

    }
    
    class SecurityInformation : Mappable{
        required init?(map: Map) {
        
        }
        init() {
            
        }
        
        func mapping(map: Map) {
            status <- map["status"]
            name <- map["name"]
            priority <- map["priority"]
            extra <- map["extra"]
            extraMessage <- map["extraMessage"]
            collapsible <- map["collapsible"]
            collapseState <- map["collapseState"]

        }
        
        enum priorityLevel : Int {
            case low = 0
            case medium = 1
            case high = 2
        }
        
        var status : Bool?
        var name : String?
        var priority : Int?
        var extra : String?
        var extraMessage : [String]?
        var collapsible = false
        var collapseState = true
    }
    mutating func setSecurityInformation(list : [SecurityInformation]){
        securityInformation = list.toJSONString()
    }
    mutating func setExposeLevel(value:Int){
        if value > exposeLevel {
            exposeLevel = value
        }
    }
    
}

extension ApplicationEntity: FetchableRecord{
    
}

extension ApplicationEntity: MutablePersistableRecord {
    // Update auto-incremented id upon successful insertion
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
extension ApplicationEntity : PersistableRecord {
    func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["image"] = image
        container["name"] = name
        container["email"] = email
        container["lastScan"] = lastScan
        container["selected"] = selected
        container["applicationName"] = applicationName
        container["securityInformation"] = securityInformation
        container["exposeLevel"] = exposeLevel
        container["suggestNumber"] = suggestNumber
        container["userId"] = userId

    }
}


