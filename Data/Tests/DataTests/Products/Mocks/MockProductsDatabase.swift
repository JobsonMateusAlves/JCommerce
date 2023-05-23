//
//  File.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

@testable import Data

class MockProductsDatabase: ProductsDatabase {
    
    var products: [ProductObject] = []
    
    func save(products: [ProductObject]) throws {
        try products.forEach { product in
            try save(product: product)
        }
    }
    
    func save(product: ProductObject) throws {
        products.append(product)
    }
    
    func getProducts() -> [ProductObject] {
        products
    }
    
    func getProduct(by codeColor: String) -> ProductObject? {
        guard let index: Int = products.firstIndex(where: { $0.codeColor == codeColor }) else { return nil }
        let product: ProductObject = products[index]
        products.remove(at: index)
        return product
    }
}
