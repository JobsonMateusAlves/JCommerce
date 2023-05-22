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
    func fetchProducts(filterByOnSale: Bool, completion: @escaping (() -> Void))
    func productAt(index: Int) -> Product
}

public class ProductsViewModelImpl: ProductsViewModel {
    
    private let getProductListUseCase: GetProductListUseCase
    private var products: [Product] = []

    public init(getProductListUseCase: GetProductListUseCase) {
        self.getProductListUseCase = getProductListUseCase
    }

    public func fetchProducts(filterByOnSale: Bool, completion: @escaping (() -> Void)) {
        getProductListUseCase.call(filterByOnSale: filterByOnSale) { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                completion()
                
            case .failure:
                completion()
            }
        }
    }
}

extension ProductsViewModelImpl {
    public var numberOfProducts: Int {
        products.count
    }

    public func productAt(index: Int) -> Product {
        products[index]
    }
}
