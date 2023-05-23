//
//  GetProductListUseCaseTests.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import XCTest
@testable import Domain

final class GetProductListUseCaseTests: XCTestCase {

    func testGetOnSaleProductList() {
        let repository = MockProductsRepository()
        let useCase: GetProductListUseCase = GetProductListUseCaseImpl(
            repository: repository
        )
        
        useCase.call(filterByOnSale: true) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 1)
                XCTAssertEqual(response.first, repository.products.last)
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testGetProductList() {
        let repository = MockProductsRepository()
        let useCase: GetProductListUseCase = GetProductListUseCaseImpl(
            repository: repository
        )
        
        useCase.call(filterByOnSale: false) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 2)
                XCTAssertEqual(response.first, repository.products.first)
                XCTAssertEqual(response.last, repository.products.last)
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}
