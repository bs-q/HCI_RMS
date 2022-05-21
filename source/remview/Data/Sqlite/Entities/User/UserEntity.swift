//
//  UserEntity.swift
//  agilemark
//
//  Created by _ on 24/12/2021.
//

import Foundation
import GRDB

struct UserEntity: Codable, Equatable {
    var id: Int64?
    var lastScan: Date?
    var scanRequestId: String
    var scanStatus: String
    var acceptTerm = false
    
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let lastScan = Column(CodingKeys.lastScan)
        static let scanRequestId = Column(CodingKeys.scanRequestId)
        static let scanStatus = Column(CodingKeys.scanStatus)
        static let acceptTerm = Column(CodingKeys.acceptTerm)
    }
}

extension UserEntity: FetchableRecord{
    
}
extension UserEntity : TableRecord {
    static let applications = hasMany(ApplicationEntity.self)
}

extension UserEntity: MutablePersistableRecord {
    // Update auto-incremented id upon successful insertion
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
