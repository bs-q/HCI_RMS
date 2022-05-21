import GRDB
import RxGRDB
import RxSwift
import Resolver


struct RestaurantDao {
    @Injected
    private var database: DatabasePool
    
    func inserOne(_ restaurant: Restaurant) -> Single<Void>  {
        var res = restaurant
        return database.rx.write(updates: { db in try res.insert(db) })
    }

    func deleteAll() -> Single<Void> {
        database.rx.write(updates: {db in try Restaurant.deleteAll(db)})
    }
    
    func deleteOne(_ restaurant: Restaurant) -> Single<Void> {
        database.rx.write(updates: { db in try restaurant.delete(db) })
    }
    
    func findById(_ id:Int64) -> Single<Restaurant?> {
        database.rx.read(value: {db in try
            Restaurant.filter(Restaurant.Columns.id == id).fetchOne(db)})
    }
    
    func findAll() -> Observable<[Restaurant]?> {
        ValueObservation.tracking { db in
            try Restaurant.fetchAll(db)
        }.rx.observe(in: database)
    }

}
