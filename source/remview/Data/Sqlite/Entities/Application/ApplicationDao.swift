//
//  ApplicationDao.swift
//  agilemark
//
//  Created by _ on 20/12/2021.
//

import Foundation
import GRDB
import RxGRDB
import RxSwift
import Resolver


struct ApplicationDao {
    @Injected
    private var database: DatabasePool
    
    func inserOne(_ application: ApplicationEntity) -> Single<Void>  {
        let res = application
        return database.rx.write(updates: { db in
            try res.insert(db) })
    }

    func deleteAll() -> Single<Void> {
        database.rx.write(updates: {db in try ApplicationEntity.deleteAll(db)})
    }
    
    func deleteOne(_ application: ApplicationEntity) -> Single<Void> {
        database.rx.write(updates: { db in try application.delete(db) })
    }
    
    func findById(_ userId:Int64,_ id:String) -> Single<ApplicationEntity?> {
        database.rx.read(value: {db in try
            ApplicationEntity.filter(ApplicationEntity.Columns.image == id && Column("userId") == userId).fetchOne(db)})
    }
    
    func findAll(_ id:Int64) -> Single<[ApplicationEntity]?> {
        database.rx.read(value: {db in try ApplicationEntity.all().filter(Column("userId") == id).order(ApplicationEntity.Columns.selected.desc).fetchAll(db)})
    }
    func selectedApplications(userId:Int64,selected : Bool) ->Single<[ApplicationEntity]?>{
        database.rx.read(value: {
            db in try
            ApplicationEntity.filter(ApplicationEntity.Columns.selected == selected && ApplicationEntity.Columns.userId == userId).fetchAll(db)
        })
    }

}
