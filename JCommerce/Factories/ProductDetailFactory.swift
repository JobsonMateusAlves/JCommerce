//
//  ProductDetailFactory.swift
//  JCommerce
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import Presentation
import Domain
import Data

final class ProductDetailFactory {
    static func createViewModel(product: Domain.Product) -> ProductDetailViewModel {
        ProductDetailViewModelImpl(product: product, purchaseUseCases: createUseCase())
    }
    
    static func createUseCase() -> PurchasesUseCases {
        PurchasesUseCasesImpl(repository: createRepository())
    }
    
    static func createRepository() -> PurchasesRepository {
        PurchasesRepositoryImpl(database: createDatabase())
    }
    
    static func createDatabase() -> PurchasesDatabase {
        PurchasesDatabaseImpl(database: Database.shared)
    }
}
