//
//  AddProductItemUseCase.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation

// MARK: protocol
public protocol AddProductItemUseCase {
    func call(_ productItem: ProductItem, completion: @escaping (Result<Purchase, Error>) -> Void)
}

// MARK: Implementation
class AddProductItemUseCaseImpl: AddProductItemUseCase {

    private let repository: PurchasesRepository
    
    init(repository: PurchasesRepository) {
        self.repository = repository
    }
    
    func call(_ productItem: ProductItem, completion: @escaping (Result<Purchase, Error>) -> Void) {
        let pending: Bool = true
        repository.fetchPurchase(by: pending) { [weak self] purchase in
            let currentPurchase: Purchase = purchase ?? Purchase(
                id: UUID().uuidString,
                items: [],
                pending: true
            )
            
            if let productItemExistingIndex = currentPurchase.items.firstIndex(
                where: { $0.product?.codeColor == productItem.product?.codeColor && $0.size?.sku == productItem.size?.sku }
            ) {
                currentPurchase.items[productItemExistingIndex].amount += 1
            } else {
                currentPurchase.items.append(productItem)
            }
            
            self?.repository.savePurchase(
                purchase: currentPurchase,
                completion: { result in
                    switch result {
                    case .success(let response):
                        completion(.success(response))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            )
        }
    }
}
