import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerApplicationContext()
        registerDatabase()
        registerApplicationConfiguration()
        registerRemoteService()
    }
}
