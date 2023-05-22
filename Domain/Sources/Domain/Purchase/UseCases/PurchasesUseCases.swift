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
public protocol PurchasesUseCases {
    
    func addProductItem(_ productItem: ProductItem, completion: @escaping (Result<Purchase, Error>) -> Void)
    func removeProductItem(_ productItem: ProductItem, type: RemotionType, completion: @escaping (Result<Purchase, Error>) -> Void)
    func fetchProductItemsInCurrentPurchase(completion: @escaping (Result<[ProductItem], Error>) -> Void)
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
    
    public func removeProductItem(_ productItem: ProductItem, type: RemotionType, completion: @escaping (Result<Purchase, Error>) -> Void) {
        let pending: Bool = true
        repository.fetchPurchase(by: pending) { [weak self] purchase in
            let currentPurchase: Purchase = purchase ?? Purchase(
                id: UUID().uuidString,
                items: [],
                pending: true
            )
            
            switch type {
            case .delete:
                currentPurchase.items.removeAll(where: { $0.id == productItem.id })
            case .decrease:
                if let index = currentPurchase.items.firstIndex(where: { $0.id == productItem.id }) {
                    currentPurchase.items[index].amount -= 1
                }
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
