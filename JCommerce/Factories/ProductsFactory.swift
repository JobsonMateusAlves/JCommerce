//
//  ProductsFactory.swift
//  JCommerce
//
//  Created by Jobson Mateus on 22/05/23.
//

import Presentation
import Domain
import Data

struct ProductsFactory {
    static func createViewModel() -> ProductsViewModel {
        Presentation.ProductsFactory.makeViewModel(
            getProductListUseCase: Domain.ProductsFactory.makeUseCase(
                repository: Data.ProductsFactory.makeRepository()
            )
        )
    }
}
