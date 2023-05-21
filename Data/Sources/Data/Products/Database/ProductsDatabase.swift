//
//  ProductsDatabase.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation

public protocol ProductsDatabase {
    func save(products: [ProductObject]) throws
    func save(product: ProductObject) throws
    func getProducts() -> [ProductObject]
}

public class ProductsDatabaseImpl: ProductsDatabase {
    
    let database: Database
    
    public init(database: Database) {
        self.database = database
    }
    
    public func save(products: [ProductObject]) throws {
        try products.forEach { product in
            try save(product: product)
        }
    }
    
    public func save(product: ProductObject) throws {
        try database.realm?.write {
            database.realm?.add(product)
        }
    }
    
    public func getProducts() -> [ProductObject] {
        if let results = database.realm?.objects(ProductObject.self) {
            var products: [ProductObject] = []
            products.append(contentsOf: results)
            return products
        }
        return []
    }
}
