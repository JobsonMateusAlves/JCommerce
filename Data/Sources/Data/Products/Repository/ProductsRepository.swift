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
    let database: ProductsDatabase
    
    public init(service: ProductsService, database: ProductsDatabase = ProductsDatabaseImpl(database: Database.shared)) {
        self.service = service
        self.database = database
    }
    
    public func fetchProducts(completion: @escaping (Result<[Domain.Product], Error>) -> Void) {
        service.fetchProducts { [weak self] result in
            switch result {
            case .success(let response):
                try? self?.database.save(products: response.products.map({ $0.toDatabase() }))
                completion(.success(response.products.map({ $0.toDomain() })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
