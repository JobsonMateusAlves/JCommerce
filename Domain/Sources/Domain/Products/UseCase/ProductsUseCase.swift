//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

// MARK: protocol
public protocol ProductsUseCase {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}

// MARK: Implementation
public final class ProductsUseCaseImpl: ProductsUseCase {

    private let repository: ProductsRepository
    
    public init(repository: ProductsRepository) {
        self.repository = repository
    }
    
    public func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        repository.fetchProducts(completion: completion)
    }
}
