//
//  Product+Extension.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation
import Domain
import RealmSwift

extension Domain.Product {
    func toDatabase() -> ProductObject {
        let sizeList = List<SizeObject>()
        sizeList.append(objectsIn: sizes.map({ $0.toDatabase() }))
        
        return ProductObject(
            name: name,
            style: style,
            codeColor: codeColor,
            colorSlug: colorSlug,
            color: color,
            onSale: onSale,
            regularPrice: regularPrice,
            actualPrice: actualPrice,
            discountPercentage: discountPercentage,
            installments: installments,
            image: image,
            sizes: sizeList
        )
    }
}
