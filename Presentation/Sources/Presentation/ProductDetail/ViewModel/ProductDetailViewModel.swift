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
    var enableConfirmButtons: Bool { get }
    func select(by title: String)
    func addToShoppingCart(completion: @escaping () -> Void)
    func onChange(_ completion: @escaping () -> Void)
}

class ProductDetailViewModelImpl: ProductDetailViewModel {
    private let addProductItemUseCase: AddProductItemUseCase
    private var completion: (() -> Void)?
    
    var product: Product
    var selectedSize: Size?

    init(product: Product, addProductItemUseCase: AddProductItemUseCase) {
        self.product = product
        self.addProductItemUseCase = addProductItemUseCase
        self.selectedSize = product.sizes.count == 1 ? product.sizes.first : nil
    }
    
    func onChange(_ completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    func select(by title: String) {
        selectedSize = product.sizes.first(where: { $0.size == title })
        completion?()
    }
    
    func addToShoppingCart(completion: @escaping () -> Void) {
        let productItem = ProductItem(
            id: UUID().uuidString,
            product: product,
            size: selectedSize,
            amount: 1
        )
        addProductItemUseCase.call(productItem) { result in
            completion()
        }
    }
}

extension ProductDetailViewModelImpl {
    var availableSizes: [Size] {
        product.sizes.filter({ $0.available })
    }
    
    var enableConfirmButtons: Bool {
        selectedSize != nil
    }
}
