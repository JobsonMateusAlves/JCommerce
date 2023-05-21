//
//  File.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation

public protocol SizesDatabase {
    func save(sizes: [SizeObject]) throws
    func save(size: SizeObject) throws
    func getSizes() -> [SizeObject]
}

public class SizesDatabaseImpl: SizesDatabase {
    
    let database: Database
    
    public init(database: Database) {
        self.database = database
    }
    
    public func save(sizes: [SizeObject]) throws {
        try sizes.forEach { size in
            try save(size: size)
        }
    }
    
    public func save(size: SizeObject) throws {
        try database.realm?.write {
            database.realm?.add(size)
        }
    }
    
    public func getSizes() -> [SizeObject] {
        if let results = database.realm?.objects(SizeObject.self) {
            var sizes: [SizeObject] = []
            sizes.append(contentsOf: results)
            return sizes
        }
        return []
    }
}
