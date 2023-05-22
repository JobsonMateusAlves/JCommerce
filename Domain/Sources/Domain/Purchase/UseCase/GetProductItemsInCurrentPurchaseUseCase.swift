//
//  GetProductItemsInCurrentPurchaseUseCase.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation

// MARK: protocol
public protocol GetProductItemsInCurrentPurchaseUseCase {
    func call(completion: @escaping (Result<[ProductItem], Error>) -> Void)
}

// MARK: Implementation
class GetProductItemsInCurrentPurchaseUseCaseImpl: GetProductItemsInCurrentPurchaseUseCase {
    
    private let repository: PurchasesRepository
    
    init(repository: PurchasesRepository) {
        self.repository = repository
    }
    
    func call(completion: @escaping (Result<[ProductItem], Error>) -> Void) {
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
