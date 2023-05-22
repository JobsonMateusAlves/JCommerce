//
//  ProductItem.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation

public class ProductItem {
    public var id: String
    public var product: Product?
    public var size: Size?
    public var amount: Int
    
    public init(id: String? = nil, product: Product?, size: Size?, amount: Int) {
        self.id = id ?? UUID().uuidString
        self.product = product
        self.size = size
        self.amount = amount
    }
}
