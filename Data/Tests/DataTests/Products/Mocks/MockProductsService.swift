//
//  MockProductsService.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

@testable import Data

class MockProductsService: ProductsService {
    let products: [Product] = [
        Product(
            name: "VESTIDO TRANSPASSE BOW",
            style: "20002605",
            codeColor: "20002605_613",
            colorSlug: "tapecaria",
            color: "TAPEÇARIA",
            onSale: false,
            regularPrice: "R$ 199,90",
            actualPrice: "R$ 199,90",
            discountPercentage: "",
            installments: "3x R$ 66,63",
            image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
            sizes: [
                Size(
                    available: true,
                    size: "P",
                    sku: "5807_343_0_P"
                ),
                Size(
                    available: true,
                    size: "M",
                    sku: "5807_343_0_M"
                ),
                Size(
                    available: true,
                    size: "G",
                    sku: "5807_343_0_G"
                )
            ]
        ),
        Product(
            name: "VESTIDO TRANSPASSE BOW 2",
            style: "20002601",
            codeColor: "20002601_614",
            colorSlug: "vermelho",
            color: "VERMELHO",
            onSale: true,
            regularPrice: "R$ 199,90",
            actualPrice: "R$ 149,90",
            discountPercentage: "",
            installments: "3x R$ 49,97",
            image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
            sizes: [
                Size(
                    available: true,
                    size: "P",
                    sku: "5807_343_0_P"
                ),
                Size(
                    available: true,
                    size: "G",
                    sku: "5807_343_0_G"
                )
            ]
        )
    ]
    
    func fetchProducts(completion: @escaping (Result<ProductsResponse, Error>) -> Void) {
        completion(
            .success(
                ProductsResponse(
                    products: products
                )
            )
        )
    }
}
