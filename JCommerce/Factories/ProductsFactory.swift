//
//  ProductsFactory.swift
//  JCommerce
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import Presentation
import Domain
import Data

final class ProductsFactory {
    static func createViewModel() -> ProductsViewModel {
        ProductsViewModelImpl(useCase: createUseCase())
    }
    
    static func createUseCase() -> ProductsUseCase {
        ProductsUseCaseImpl(repository: createRepository())
    }
    
    static func createRepository() -> ProductsRepository {
        ProductsRepositoryImpl(service: createService())
    }
    
    static func createService() -> ProductsService {
        ProductsServiceImpl()
    }
}
