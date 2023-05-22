//
//  ProductDetailFactory.swift
//  JCommerce
//
//  Created by Jobson Mateus on 22/05/23.
//

import Presentation
import Domain
import Data

struct ProductDetailFactory {
    static func createViewModel(product: Product) -> ProductDetailViewModel {
        Presentation.ProductDetailFactory.makeViewModel(
            product: product,
            addProductItemUseCase: Domain.PurchaseFactory.makeAddProductItemUseCase(
                repository: Data.PurchaseFactory.makeRepository()
            )
        )
    }
}
