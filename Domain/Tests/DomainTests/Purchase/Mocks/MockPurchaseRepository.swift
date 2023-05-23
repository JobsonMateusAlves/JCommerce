//
//  File.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation
@testable import Domain

class MockPurchaseRepository: PurchasesRepository {
    
    var purchase: Purchase?
    
    init(purchase: Purchase?) {
        self.purchase = purchase
    }
    
    func fetchPurchase(by pending: Bool, completion: @escaping (Domain.Purchase?) -> Void) {
        completion(purchase)
    }
    
    func savePurchase(purchase: Domain.Purchase, completion: @escaping (Result<Domain.Purchase, Error>) -> Void) {
        self.purchase = purchase
        completion(.success(purchase))
    }
}
