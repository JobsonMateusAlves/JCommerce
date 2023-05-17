//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation
import Domain

struct Product: Codable {
    var name: String
    var style: String
    var codeColor: String
    var colorSlug: String
    var color: String
    var onSale: Bool
    var regularPrice: String
    var actualPrice: String
    var discountPercentage: String
    var installments: String
    var image: String
    var sizes: [Size]
    
    enum CodingKeys: String, CodingKey {
        case name
        case style
        case codeColor = "code_color"
        case colorSlug = "color_slug"
        case color
        case onSale = "on_sale"
        case regularPrice = "regular_price"
        case actualPrice = "actual_price"
        case discountPercentage = "discount_percentage"
        case installments
        case image
        case sizes
    }
}

extension Product {
    func toDomain() -> Domain.Product {
        Domain.Product(
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
            sizes: sizes.map({ $0.toDomain() })
        )
    }
}
