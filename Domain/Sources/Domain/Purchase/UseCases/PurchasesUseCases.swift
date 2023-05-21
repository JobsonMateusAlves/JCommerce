//
//  PurchaseUseCase.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation

// MARK: protocol
public protocol PurchasesUseCases {
    func addProductItem(_ productItem: ProductItem, completion: @escaping (Result<Purchase, Error>) -> Void)
}

// MARK: Implementation
public class PurchasesUseCasesImpl: PurchasesUseCases {
    
    private let repository: PurchasesRepository
    
    public init(repository: PurchasesRepository) {
        self.repository = repository
    }
    
    public func addProductItem(_ productItem: ProductItem, completion: @escaping (Result<Purchase, Error>) -> Void) {
        let pending: Bool = true
        repository.fetchPurchase(by: pending) { [weak self] purchase in
            let newPurchase: Purchase = purchase ?? Purchase(
                id: UUID().uuidString,
                items: [],
                pending: true
            )
            
            newPurchase.items.append(productItem)
            self?.repository.savePurchase(
                purchase: newPurchase,
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
