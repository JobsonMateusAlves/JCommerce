//
//  ProductDetailFactory.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation
import Domain

public struct ProductDetailFactory {
    public static func makeViewModel(product: Product, addProductItemUseCase: AddProductItemUseCase) -> ProductDetailViewModel {
        ProductDetailViewModelImpl(product: product, addProductItemUseCase: addProductItemUseCase)
    }
}
