//
//  UserDao.swift.swift
//  agilemark
//
//  Created by _ on 24/12/2021.
//

import Foundation
import GRDB
import RxGRDB
import RxSwift
import Resolver


struct UserDao {
    @Injected
    private var database: DatabasePool
    
    func inserOne(_ user: UserEntity) -> Single<Void>  {
        var res = user
        return database.rx.write(updates: { db in
            
            
            
            try res.insert(db) })
    }
    func updateUser(_ user: UserEntity) -> Single<Void>  {
        var res = user
        return database.rx.write(updates: { db in
            try res.update(db) })
    }
    
    func createUser(_ user: UserEntity) -> Single<Void>  {
        var usr = user
        
        return database.rx.write(updates: { db in
            try usr.insert(db)

            var instagram = ApplicationEntity()
            instagram.userId = usr.id
            instagram.applicationName = ApplicationEntity.applicationType.instagram.rawValue
            instagram.image = ApplicationEntity.applicationType.instagram.rawValue
            try instagram.insert(db)
            
            var linkedIn = ApplicationEntity()
            linkedIn.userId = usr.id
            linkedIn.name = ApplicationEntity.applicationType.linkedIn.rawValue
            linkedIn.image = ApplicationEntity.applicationType.linkedIn.rawValue
            try linkedIn.insert(db)
            
            var twitter = ApplicationEntity()
            twitter.userId = usr.id
            twitter.name = ApplicationEntity.applicationType.twitter.rawValue
            twitter.image = ApplicationEntity.applicationType.twitter.rawValue
            try twitter.insert(db)
            
            var facebook = ApplicationEntity()
            facebook.userId = usr.id
            facebook.name = ApplicationEntity.applicationType.facebook.rawValue
            facebook.image = ApplicationEntity.applicationType.facebook.rawValue
            try facebook.insert(db)
            
            
            
            
        })
    }
    
    
    func deleteAll() -> Single<Void> {
        database.rx.write(updates: {db in try UserEntity.deleteAll(db)})
    }
    
    func deleteOne(_ user: UserEntity) -> Single<Void> {
        database.rx.write(updates: { db in try user.delete(db) })
    }
    
    func findById(_ id:Int64) -> Single<UserEntity?> {
        database.rx.read(value: {db in try
            UserEntity.filter(UserEntity.Columns.id == id).fetchOne(db)})
    }
    
    func findAll() -> Single<[UserEntity]?> {
        database.rx.read(value: {db in try UserEntity.all().order().fetchAll(db)})
    }

}
