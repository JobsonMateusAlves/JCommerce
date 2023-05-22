//
//  Database.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import RealmSwift

final class Database {
    static let shared: Database = {
        Database()
    }()
    
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
