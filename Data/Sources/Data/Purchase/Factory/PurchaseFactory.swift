//
//  PurchaseFactory.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation
import Domain

public struct PurchaseFactory {
    public static func makeRepository() -> PurchasesRepository {
        PurchasesRepositoryImpl(database: makeDatabase())
    }
    
    public static func makeDatabase() -> PurchasesDatabase {
        PurchasesDatabaseImpl(database: Database.shared)
    }
}
