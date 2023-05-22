//
//  File.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation

// MARK: protocol
public protocol GetProductListUseCase {
    func call(filterByOnSale: Bool, completion: @escaping (Result<[Product], Error>) -> Void)
}

// MARK: Implementation
final class GetProductListUseCaseImpl: GetProductListUseCase {

    private let repository: ProductsRepository
    
    init(repository: ProductsRepository) {
        self.repository = repository
    }
    
    func call(filterByOnSale: Bool, completion: @escaping (Result<[Product], Error>) -> Void) {
        repository.fetchProducts { result in
            switch result {
            case .success(let response):
                if filterByOnSale {
                    completion(.success(response.filter({ $0.onSale })))
                } else {
                    completion(.success(response))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
