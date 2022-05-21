import Foundation
import Resolver
import GRDB


extension Resolver.Name {
    static let database = Self("database")
    static let databaseMode = database
}

extension Resolver {
    public static func registerDatabase() {
        register { RestaurantDao() }
        register { ApplicationDao() }
        register { UserDao()}
    }
    
}
