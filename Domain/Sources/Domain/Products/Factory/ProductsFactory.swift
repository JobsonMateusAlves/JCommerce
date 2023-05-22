//
//  File.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation

public struct ProductsFactory {
    public static func makeUseCase(repository: ProductsRepository) -> GetProductListUseCase {
        GetProductListUseCaseImpl(repository: repository)
    }
}
