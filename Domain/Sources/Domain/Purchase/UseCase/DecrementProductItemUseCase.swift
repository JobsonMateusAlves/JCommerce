//
//  PurchaseUseCase.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation

public enum RemotionType {
    case delete
    case decrease
}

// MARK: protocol
public protocol DecrementProductItemUseCase {
    func call(_ productItem: ProductItem, completion: @escaping (Result<Purchase, Error>) -> Void)
}

// MARK: Implementation
class DecrementProductItemUseCaseImpl: DecrementProductItemUseCase {
    
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
            
            if let index = currentPurchase.items.firstIndex(where: { $0.id == productItem.id }) {
                currentPurchase.items[index].amount -= 1
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
    
    public func fetchProductItemsInCurrentPurchase(completion: @escaping (Result<[ProductItem], Error>) -> Void) {
        let pending: Bool = true
        repository.fetchPurchase(by: pending) { purchase in
            let currentPurchase: Purchase = purchase ?? Purchase(
                id: UUID().uuidString,
                items: [],
                pending: true
            )
            
            completion(.success(currentPurchase.items))
        }
    }
}
