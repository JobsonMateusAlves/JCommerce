//
//  ProductsViewModel.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import Domain

public protocol ProductsViewModel {
    var numberOfProducts: Int { get }
    var error: String? { get }
    func fetchProducts(completion: @escaping (() -> Void))
    func productAt(index: Int) -> Product
}

public class ProductsViewModelImpl: ProductsViewModel {
    
    private let useCase: ProductsUseCase

    private var products: [Product] = []
    private var fetchProductsError: String?

    public init(useCase: ProductsUseCase) {
        self.useCase = useCase
    }

    public func fetchProducts(completion: @escaping (() -> Void)) {
        useCase.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                completion()
                
            case .failure(let error):
                self?.fetchProductsError = error.localizedDescription
                completion()
            }
        }
    }
}

extension ProductsViewModelImpl {
    public var numberOfProducts: Int {
        products.count
    }
    
    public var error: String? {
        fetchProductsError
    }

    public func productAt(index: Int) -> Product {
        products[index]
    }
}
