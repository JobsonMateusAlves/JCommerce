//
//  File.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation

public protocol PurchasesDatabase {
    func save(purchases: [PurchaseObject]) throws
    func save(purchase: PurchaseObject) throws
    func getPurchases() -> [PurchaseObject]
    func getPurchase(pending: Bool) -> PurchaseObject?
}

public class PurchasesDatabaseImpl: PurchasesDatabase {
    
    let database: Database
    
    public init(database: Database) {
        self.database = database
    }
    
    public func save(purchases: [PurchaseObject]) throws {
        try purchases.forEach { purchase in
            try save(purchase: purchase)
        }
    }
    
    public func save(purchase: PurchaseObject) throws {
        try database.realm?.write {
            database.realm?.add(purchase, update: .modified)
        }
    }
    
    public func getPurchases() -> [PurchaseObject] {
        if let results = database.realm?.objects(PurchaseObject.self) {
            var purchases: [PurchaseObject] = []
            purchases.append(contentsOf: results)
            return purchases
        }
        return []
    }
    
    public func getPurchase(pending: Bool) -> PurchaseObject? {
        database.realm?.objects(PurchaseObject.self).first(where: { $0.pending })
    }
}
