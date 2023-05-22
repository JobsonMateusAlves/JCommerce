//
//  ShoppingCartFactory.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation
import Domain

public struct ShoppingCartFactory {
    public static func makeViewModel(
        getProductItemsInCurrentPurchaseUseCase: GetProductItemsInCurrentPurchaseUseCase,
        addProductItemUseCase: AddProductItemUseCase,
        decrementProductItemUseCase: DecrementProductItemUseCase,
        deleteProductItemUseCase: DeleteProductItemUseCase
    ) -> ShoppingCartViewModel {
        ShoppingCartViewModelImpl(
            getProductItemsInCurrentPurchaseUseCase: getProductItemsInCurrentPurchaseUseCase,
            addProductItemUseCase: addProductItemUseCase,
            decrementProductItemUseCase: decrementProductItemUseCase,
            deleteProductItemUseCase: deleteProductItemUseCase
        )
    }
}
