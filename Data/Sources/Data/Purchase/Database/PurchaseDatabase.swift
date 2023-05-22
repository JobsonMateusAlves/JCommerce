//
//  PurchasesDatabase.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation

protocol PurchasesDatabase {
    func save(purchases: [PurchaseObject]) throws
    func save(purchase: PurchaseObject) throws
    func getPurchases() -> [PurchaseObject]
    func getPurchase(pending: Bool) -> PurchaseObject?
}

class PurchasesDatabaseImpl: PurchasesDatabase {
    
    let database: Database
    
    init(database: Database) {
        self.database = database
    }
    
    func save(purchases: [PurchaseObject]) throws {
        try purchases.forEach { purchase in
            try save(purchase: purchase)
        }
    }
    
    func save(purchase: PurchaseObject) throws {
        try database.realm?.write {
            database.realm?.add(purchase, update: .modified)
        }
    }
    
    func getPurchases() -> [PurchaseObject] {
        if let results = database.realm?.objects(PurchaseObject.self) {
            var purchases: [PurchaseObject] = []
            purchases.append(contentsOf: results)
            return purchases
        }
        return []
    }
    
    func getPurchase(pending: Bool) -> PurchaseObject? {
        database.realm?.objects(PurchaseObject.self).first(where: { $0.pending })
    }
}
