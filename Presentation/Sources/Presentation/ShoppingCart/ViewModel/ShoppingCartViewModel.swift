//
//  File.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation
import Domain

public protocol ShoppingCartViewModel {
    var numberOfProductItems: Int { get }
    var error: String? { get }
    func productItemAt(index: Int) -> ProductItem
    func fetchProductItems(completion: @escaping () -> Void)
    func increaseAmount(productItem: ProductItem, completion: @escaping (Int) -> Void)
    func decreaseAmount(productItem: ProductItem, completion: @escaping (Int) -> Void)
}

public class ShoppingCartViewModelImpl: ShoppingCartViewModel {
    
    private let useCases: PurchasesUseCases
    private var productItems: [ProductItem] = []
    public var fetchProductItemsError: String?

    public init(useCases: PurchasesUseCases) {
        self.useCases = useCases
    }
    
    public func fetchProductItems(completion: @escaping () -> Void) {
        useCases.fetchProductItemsInCurrentPurchase { [weak self] result in
            switch result {
            case .success(let response):
                self?.productItems = response
                completion()
            case .failure(let error):
                self?.fetchProductItemsError = error.localizedDescription
                completion()
            }
        }
    }
    
    public func increaseAmount(productItem: Domain.ProductItem, completion: @escaping (Int) -> Void) {
        guard let index: Int = productItems.firstIndex(where: { $0.id == productItem.id }) else { return }
        productItems[index].amount += 1
        completion(index)
    }
    
    public func decreaseAmount(productItem: Domain.ProductItem, completion: @escaping (Int) -> Void) {
        guard let index: Int = productItems.firstIndex(where: { $0.id == productItem.id }) else { return }
        if productItems[index].amount > 1 {
            productItems[index].amount -= 1
            completion(index)
        }
    }
}

extension ShoppingCartViewModelImpl {
    public var numberOfProductItems: Int {
        productItems.count
    }
    
    public var error: String? {
        fetchProductItemsError
    }

    public func productItemAt(index: Int) -> ProductItem {
        productItems[index]
    }
}
