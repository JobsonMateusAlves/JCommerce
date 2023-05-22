//
//  ProductsFactory.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation
import Domain

public struct ProductsFactory {
    public static func makeRepository() -> ProductsRepository {
        ProductsRepositoryImpl(service: makeService(), database: makeDatabase())
    }
    
    static func makeService() -> ProductsService {
        ProductsServiceImpl()
    }
    
    static func makeDatabase() -> ProductsDatabase {
        ProductsDatabaseImpl(database: Database.shared)
    }
}
