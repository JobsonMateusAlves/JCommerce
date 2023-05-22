//
//  DeleteProductItemUseCase.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation

// MARK: protocol
public protocol DeleteProductItemUseCase {
    func call(_ productItem: ProductItem, completion: @escaping (Result<Purchase, Error>) -> Void)
}

// MARK: Implementation
class DeleteProductItemUseCaseImpl: DeleteProductItemUseCase {
    
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
            
            currentPurchase.items.removeAll(where: { $0.id == productItem.id })
            
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
