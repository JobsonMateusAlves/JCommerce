//
//  ProductsFactory.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation
import Domain

public struct ProductsFactory {
    public static func makeRepository() -> ProductsRepository {
        ProductsRepositoryImpl(service: makeService())
    }
    
    public static func makeService() -> ProductsService {
        ProductsServiceImpl()
    }
}
