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
    var totalProductsPrice: String { get }
    var error: String? { get }
    func productItemAt(index: Int) -> ProductItem
    func fetchProductItems(completion: @escaping () -> Void)
    func increaseAmount(productItem: ProductItem, completion: @escaping (Int) -> Void)
    func decreaseAmount(productItem: ProductItem, completion: @escaping (Int) -> Void)
    func remove(productItem: ProductItem, completion: @escaping () -> Void)
}

public class ShoppingCartViewModelImpl: ShoppingCartViewModel {
    private let getProductItemsInCurrentPurchaseUseCase: GetProductItemsInCurrentPurchaseUseCase
    private let addProductItemUseCase: AddProductItemUseCase
    private let decrementProductItemUseCase: DecrementProductItemUseCase
    private let deleteProductItemUseCase: DeleteProductItemUseCase
    
    private var productItems: [ProductItem] = []
    public var fetchProductItemsError: String?

    public init(
        getProductItemsInCurrentPurchaseUseCase: GetProductItemsInCurrentPurchaseUseCase,
        addProductItemUseCase: AddProductItemUseCase,
        decrementProductItemUseCase: DecrementProductItemUseCase,
        deleteProductItemUseCase: DeleteProductItemUseCase
    ) {
        self.getProductItemsInCurrentPurchaseUseCase = getProductItemsInCurrentPurchaseUseCase
        self.addProductItemUseCase = addProductItemUseCase
        self.decrementProductItemUseCase = decrementProductItemUseCase
        self.deleteProductItemUseCase = deleteProductItemUseCase
    }
    
    public func fetchProductItems(completion: @escaping () -> Void) {
        getProductItemsInCurrentPurchaseUseCase.call { [weak self] result in
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
        
        addProductItemUseCase.call(productItems[index]) { [weak self] result in
            switch result {
            case .success:
                completion(index)
            case .failure:
                self?.productItems[index].amount -= 1
                completion(index)
            }
        }
    }
    
    public func decreaseAmount(productItem: Domain.ProductItem, completion: @escaping (Int) -> Void) {
        guard let index: Int = productItems.firstIndex(where: { $0.id == productItem.id }) else { return }
        guard productItems[index].amount > 1 else { return }
        productItems[index].amount -= 1
        
        decrementProductItemUseCase.call(productItems[index]) { [weak self] result in
            switch result {
            case .success:
                completion(index)
            case .failure:
                self?.productItems[index].amount += 1
                completion(index)
            }
        }
    }
    
    public func remove(productItem: ProductItem, completion: @escaping () -> Void) {
        guard let index: Int = productItems.firstIndex(where: { $0.id == productItem.id }) else { return }
        deleteProductItemUseCase.call(productItems[index]) { [weak self] result in
            switch result {
            case .success(let purchase):
                self?.productItems = purchase.items
                completion()
            case .failure:
                completion()
            }
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
    
    public var totalProductsPrice: String {
        let sum: Double = productItems.reduce(0) { partialResult, productItem in
            guard let priceString = productItem.product?.actualPrice.components(separatedBy: " ").last,
                  let price = Double(priceString.replacingOccurrences(of: ",", with: "."))
            else {
                return partialResult
            }
            
            return partialResult + (Double(productItem.amount) * price)
        }
        return "R$ \(sum.toString(with: 2))"
    }

    public func productItemAt(index: Int) -> ProductItem {
        productItems[index]
    }
}
