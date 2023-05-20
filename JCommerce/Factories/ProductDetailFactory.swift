//
//  ProductDetailFactory.swift
//  JCommerce
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import Presentation
import Domain
import Data

final class ProductDetailFactory {
    static func createViewModel(product: Domain.Product) -> ProductDetailViewModel {
        ProductDetailViewModelImpl(product: product)
    }
}
