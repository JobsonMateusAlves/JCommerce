//
//  Database.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import RealmSwift

protocol Database {
    static var shared: Database { get set }
    var realm: Realm? { get set }
}

final class DatabaseImpl: Database {
    static var shared: Database = DatabaseImpl()
    var realm: Realm?
    
    private init() {
        do {
            self.realm = try Realm()
            print("Database initialized")
        } catch {
            print("Fail to initialize Database: \(error.localizedDescription)")
        }
    }
}
