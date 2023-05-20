//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation
import Domain

public final class ProductsRepositoryImpl: Domain.ProductsRepository {
    let service: ProductsService
    
    public init(service: ProductsService) {
        self.service = service
    }
    
    public func fetchProducts(completion: @escaping (Result<[Domain.Product], Error>) -> Void) {
        service.fetchProducts { result in
            switch result {
            case .success(let response):
                completion(.success(response.products.map({ $0.toDomain() })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
