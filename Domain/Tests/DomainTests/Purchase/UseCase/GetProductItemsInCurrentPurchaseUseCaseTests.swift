//
//  GetProductItemsInCurrentPurchaseUseCaseTests.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import XCTest
@testable import Domain

final class GetProductItemsInCurrentPurchaseUseCaseTests: XCTestCase {

    let sizes = [
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
    
    var product1: Product {
        Domain.Product(
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
            sizes: sizes
        )
    }
    
    var product2: Product {
        Domain.Product(
            name: "VESTIDO TRANSPASSE BOW",
            style: "20002602",
            codeColor: "20002602_613",
            colorSlug: "vermelho",
            color: "VERMELHO",
            onSale: true,
            regularPrice: "R$ 199,90",
            actualPrice: "R$ 180,00",
            discountPercentage: "",
            installments: "3x R$ 90,00",
            image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912",
            sizes: sizes
        )
    }
    
    func testGetProductItemsInCurrentPurchase() {
        let purchase = Purchase(
            id: "Purchase_ID",
            items: [
                ProductItem(
                    product: product1,
                    size: sizes.first,
                    amount: 2
                ),
                ProductItem(
                    product: product2,
                    size: sizes.last,
                    amount: 1
                )
            ],
            pending: true
        )
        
        let repository = MockPurchaseRepository(purchase: purchase)
        let useCase: GetProductItemsInCurrentPurchaseUseCase = GetProductItemsInCurrentPurchaseUseCaseImpl(
            repository: repository
        )
        
        useCase.call { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 2)
                XCTAssertEqual(response.first?.amount, 2)
                XCTAssertEqual(response.last?.amount, 1)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
