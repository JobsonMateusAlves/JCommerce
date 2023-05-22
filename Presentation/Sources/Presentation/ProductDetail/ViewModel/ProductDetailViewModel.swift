//
//  ProductDetailViewModel.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import Domain

public protocol ProductDetailViewModel {
    var product: Product { get set }
    var selectedSize: Size? { get set }
    var availableSizes: [Size] { get }
    func select(by title: String)
    func addToShoppingCart(completion: @escaping () -> Void)
    func onChange(_ completion: @escaping () -> Void)
    
}

public class ProductDetailViewModelImpl: ProductDetailViewModel {
    public var product: Product
    public var selectedSize: Size?
    
    private let addProductItemUseCase: AddProductItemUseCase
    private var completion: (() -> Void)?

    public init(product: Product, addProductItemUseCase: AddProductItemUseCase) {
        self.product = product
        self.addProductItemUseCase = addProductItemUseCase
        self.selectedSize = product.sizes.count == 1 ? product.sizes.first : nil
    }
    
    public func onChange(_ completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    public func select(by title: String) {
        selectedSize = product.sizes.first(where: { $0.size == title })
        completion?()
    }
    
    public func addToShoppingCart(completion: @escaping () -> Void) {
        let productItem = ProductItem(
            id: UUID().uuidString,
            product: product,
            size: selectedSize,
            amount: 1
        )
        addProductItemUseCase.call(productItem) { [weak self] result in
            switch result {
            case .success:
                completion()
            case .failure(let error):
                completion()
            }
        }
    }
}

extension ProductDetailViewModelImpl {
    public var availableSizes: [Size] {
        product.sizes.filter({ $0.available })
    }
}
