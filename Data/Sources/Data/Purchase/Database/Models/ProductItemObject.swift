//
//  ProductItemObject.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import RealmSwift
import Domain

class ProductItemObject: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var product: ProductObject?
    @Persisted var size: SizeObject?
    @Persisted var amount: Int = 0
    
    convenience init(id: String, product: ProductObject?, size: SizeObject?, amount: Int) {
        self.init()
        self.id = id
        self.product = product
        self.size = size
        self.amount = amount
    }
}

extension ProductItemObject {
    func toDomain() -> Domain.ProductItem {
        Domain.ProductItem(
            id: id,
            product: product?.toDomain(),
            size: size?.toDomain(),
            amount: amount
        )
    }
}
