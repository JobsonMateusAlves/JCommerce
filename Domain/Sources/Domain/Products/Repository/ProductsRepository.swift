//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

public protocol ProductsRepository {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
