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

    private let productsRepository: ProductsRepository
    
    public init(productsRepository: ProductsRepository) {
        self.productsRepository = productsRepository
    }
    
    public func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        productsRepository.fetchProducts(completion: completion)
    }
}
