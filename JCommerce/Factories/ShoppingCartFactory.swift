//
//  ShoppingCartFactory.swift
//  JCommerce
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation
import Presentation
import Domain
import Data

final class ShoppingCartFactory {
    static func createViewModel() -> ShoppingCartViewModel {
        ShoppingCartViewModelImpl(useCases: createUseCases())
    }
    
    static func createUseCases() -> PurchasesUseCases {
        PurchasesUseCasesImpl(repository: createRepository())
    }
    
    static func createRepository() -> PurchasesRepository {
        PurchasesRepositoryImpl(database: createDatabase())
    }
    
    static func createDatabase() -> PurchasesDatabase {
        PurchasesDatabaseImpl(database: Database.shared)
    }
}
