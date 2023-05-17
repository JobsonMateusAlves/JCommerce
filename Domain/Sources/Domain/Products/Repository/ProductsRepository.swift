//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

protocol ProductsRepository {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
