//
//  ProductObject.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import RealmSwift

public class ProductObject: Object {
    @Persisted(primaryKey: true) var codeColor: String = ""
    @Persisted var name: String = ""
    @Persisted var style: String = ""
    @Persisted var colorSlug: String = ""
    @Persisted var color: String = ""
    @Persisted var onSale: Bool = false
    @Persisted var regularPrice: String = ""
    @Persisted var actualPrice: String = ""
    @Persisted var discountPercentage: String = ""
    @Persisted var installments: String = ""
    @Persisted var image: String = ""
    @Persisted var sizes: List<SizeObject> = List<SizeObject>()
    
    convenience init(name: String, style: String, codeColor: String, colorSlug: String, color: String, onSale: Bool, regularPrice: String, actualPrice: String, discountPercentage: String, installments: String, image: String, sizes: List<SizeObject>) {
        self.init()
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
