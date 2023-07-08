//
//  File.swift
//  
//
//  Created by Jobson Mateus on 11/06/23.
//

import Foundation
import Domain

public class ProductListViewModel: ObservableObject {
    
    private let getProductListUseCase: GetProductListUseCase
    @Published public var products: [Product] = []

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
