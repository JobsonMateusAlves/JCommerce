//
//  DeleteProductItemUseCaseTests.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import XCTest
@testable import Domain

final class DeleteProductItemUseCaseTests: XCTestCase {
    
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
    
    func testDecrementItem() {
        let purchase = Purchase(
            id: "Purchase_ID",
            items: [
                ProductItem(
                    id: "ProductItem_ID",
                    product: product1,
                    size: sizes.first,
                    amount: 2
                )
            ],
            pending: true
        )
        
        let repository = MockPurchaseRepository(purchase: purchase)
        let useCase: DeleteProductItemUseCase = DeleteProductItemUseCaseImpl(
            repository: repository
        )
        
        useCase.call(
            ProductItem(
                id: "ProductItem_ID",
                product: product1,
                size: sizes.first,
                amount: 1
            ),
            completion: { result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.items.count, 0)

                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }
        )
    }
}
