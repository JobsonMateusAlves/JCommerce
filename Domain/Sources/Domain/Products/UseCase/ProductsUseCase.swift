//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

// MARK: protocol
public protocol ProductsUseCase {
    func fetchProducts(onSale: Bool, completion: @escaping (Result<[Product], Error>) -> Void)
}

// MARK: Implementation
public final class ProductsUseCaseImpl: ProductsUseCase {

    private let repository: ProductsRepository
    
    public init(repository: ProductsRepository) {
        self.repository = repository
    }
    
    public func fetchProducts(onSale: Bool, completion: @escaping (Result<[Product], Error>) -> Void) {
        repository.fetchProducts { result in
            switch result {
            case .success(let response):
                completion(.success(response.filter({ $0.onSale == onSale })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
