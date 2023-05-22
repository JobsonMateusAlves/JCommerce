//
//  ShoppingCartFactory.swift
//  JCommerce
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation
import Presentation
import Domain
import Data

struct ShoppingCartFactory {
    static func createViewModel() -> ShoppingCartViewModel {
        Presentation.ShoppingCartFactory.makeViewModel(
            getProductItemsInCurrentPurchaseUseCase: Domain.PurchaseFactory.makeAddProductItemUseCase(
                repository: PurchaseFactory.makeRepository()
            ),
            addProductItemUseCase: Domain.PurchaseFactory.makeAddProductItemUseCase(
                repository: PurchaseFactory.makeRepository()
            ),
            decrementProductItemUseCase: Domain.PurchaseFactory.makeAddProductItemUseCase(
                repository: PurchaseFactory.makeRepository()
            ),
            deleteProductItemUseCase: Domain.PurchaseFactory.makeAddProductItemUseCase(
                repository: PurchaseFactory.makeRepository()
            )
        )
    }
}
