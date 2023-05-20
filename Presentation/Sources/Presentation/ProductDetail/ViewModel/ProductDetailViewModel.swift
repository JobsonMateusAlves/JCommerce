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
}

public class ProductDetailViewModelImpl: ProductDetailViewModel {
    public var product: Product
    public var selectedSize: Size?

    public init(product: Product) {
        self.product = product
    }
}
