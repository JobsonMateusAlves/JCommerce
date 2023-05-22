//
//  PurchaseFactory.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation

public struct PurchaseFactory {
    public static func makeAddProductItemUseCase(repository: PurchasesRepository) -> AddProductItemUseCase {
        AddProductItemUseCaseImpl(repository: repository)
    }
    
    public static func makeAddProductItemUseCase(repository: PurchasesRepository) -> DecrementProductItemUseCase {
        DecrementProductItemUseCaseImpl(repository: repository)
    }
    
    public static func makeAddProductItemUseCase(repository: PurchasesRepository) -> DeleteProductItemUseCase {
        DeleteProductItemUseCaseImpl(repository: repository)
    }
    
    public static func makeAddProductItemUseCase(repository: PurchasesRepository) -> GetProductItemsInCurrentPurchaseUseCase {
        GetProductItemsInCurrentPurchaseUseCaseImpl(repository: repository)
    }
}
