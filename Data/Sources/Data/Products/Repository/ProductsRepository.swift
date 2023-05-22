//
//  ProductsRepository.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation
import Domain

final class ProductsRepositoryImpl: Domain.ProductsRepository {
    let service: ProductsService
    let database: ProductsDatabase
    
    init(service: ProductsService, database: ProductsDatabase) {
        self.service = service
        self.database = database
    }
    
    func fetchProducts(completion: @escaping (Result<[Domain.Product], Error>) -> Void) {
        service.fetchProducts { [weak self] result in
            switch result {
            case .success(let response):
                let productObjects = response.products.map({ $0.toDatabase() })
                try? self?.database.save(products: productObjects)
                
                completion(.success(productObjects.map({ $0.toDomain() })))
                
            case .failure(let error):
                
                completion(.failure(error))
            }
        }
    }
}
