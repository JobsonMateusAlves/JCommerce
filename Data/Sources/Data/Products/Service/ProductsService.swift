//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation
import Domain

public protocol ProductsService {
    func fetchProducts(completion: @escaping (Result<ProductsResponse, Error>) -> Void)
}

public final class ProductsServiceImpl: Provider, ProductsService {
    public func fetchProducts(completion: @escaping (Result<ProductsResponse, Error>) -> Void) {
        request(
            target: ProductsAPI.fetchProducts,
            responseType: ProductsResponse.self,
            completion: completion
        )
    }
}
