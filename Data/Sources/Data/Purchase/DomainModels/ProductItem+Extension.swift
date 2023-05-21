//
//  ProductItem+Extension.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation
import Domain

extension ProductItem {
    func toDatabase() -> ProductItemObject {
        ProductItemObject(
           id: id,
           product: product?.toDatabase(),
           size: size?.toDatabase(),
           amount: amount
        )
    }
}
