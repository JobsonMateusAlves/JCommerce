//
//  Product.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

public struct Product: Equatable {
    public var name: String
    public var style: String
    public var codeColor: String
    public var colorSlug: String
    public var color: String
    public var onSale: Bool
    public var regularPrice: String
    public var actualPrice: String
    public var discountPercentage: String
    public var installments: String
    public var image: String
    public var sizes: [Size]
    
    public init(name: String, style: String, codeColor: String, colorSlug: String, color: String, onSale: Bool, regularPrice: String, actualPrice: String, discountPercentage: String, installments: String, image: String, sizes: [Size]) {
        self.name = name
        self.style = style
        self.codeColor = codeColor
        self.colorSlug = colorSlug
        self.color = color
        self.onSale = onSale
        self.regularPrice = regularPrice
        self.actualPrice = actualPrice
        self.discountPercentage = discountPercentage
        self.installments = installments
        self.image = image
        self.sizes = sizes
    }
}
