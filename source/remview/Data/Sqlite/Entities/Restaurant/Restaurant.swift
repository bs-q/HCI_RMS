import GRDB

struct Restaurant: Codable, Equatable {
    var id: String?
    var posId: String?
    var name: String?
    var token: String?
    var setting : String?
    var lastAccessDate: Date?
    var active : Bool?
    
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let posId = Column(CodingKeys.posId)
        static let name = Column(CodingKeys.name)
        static let token = Column(CodingKeys.token)
        static let setting = Column(CodingKeys.setting)
        static let lastAccessDate = Column(CodingKeys.lastAccessDate)
    }
    func getSetting()->RestaurantSetting {
        RestaurantSetting(JSONString: setting!, context: nil)!
    }
    
}

extension Restaurant: FetchableRecord{
    
}

extension Restaurant: MutablePersistableRecord {
    
}
extension Restaurant : PersistableRecord {
    func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["posId"] = posId
        container["name"] = name
        container["token"] = token
        container["setting"] = setting
        container["lastAccessDate"] = lastAccessDate
    }
}

