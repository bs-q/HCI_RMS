import GRDB
/// A type responsible for initializing an application database.
struct AppDatabase {
    
    /// Prepares a fully initialized database at path
    func setup(_ database: DatabaseWriter) throws {
        // Use DatabaseMigrator to define the database schema
        // See https://github.com/groue/GRDB.swift/#migrations
        try migrator.migrate(database)
        
        // Other possible setup include: custom functions, collations,
        // full-text tokenizers, etc.
    }
    
    /// The DatabaseMigrator that defines the database schema.
    // See https://github.com/groue/GRDB.swift/#migrations
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
            // delete db and recreate
            migrator.eraseDatabaseOnSchemaChange = true
        #endif
        migrator.registerMigration("term") { db in
            //another table here
            try db.create(table: "restaurant") { t in
                t.primaryKey(["posId"],onConflict: .replace)
                t.column("id", .text)
                t.column("posId", .text).notNull()
                t.column("name", .text).notNull()
                t.column("token", .text)
                t.column("setting", .text)
                t.column("lastAccessDate", .integer)

            }
            try db.create(table: "userEntity") { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("lastScan", .date)
                t.column("scanStatus", .boolean)
                t.column("scanRequestId", .text)
                t.column("acceptTerm", .boolean)
            }
            try db.create(table : "applicationEntity") {
                t in
                t.autoIncrementedPrimaryKey("id", onConflict: .replace)
                t.column("image", .text)
                t.column("name", .text)
                t.column("email",.text)
                t.column("lastScan",.integer)
                t.column("selected",.boolean)
                t.column("applicationName",.text)
                t.column("securityInformation",.text)
                t.column("exposeLevel", .integer)
                t.column("suggestNumber",  .integer)
                t.column("userId",.integer).notNull()
                    .indexed()
                    .references("userEntity",onDelete: .cascade)
            }
            
            
            
        }
        
        return migrator
    }
    
    
}
