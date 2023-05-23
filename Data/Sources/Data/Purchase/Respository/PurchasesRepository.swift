//
//  PurchaseRepository.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation
import Domain

final class PurchasesRepositoryImpl: Domain.PurchasesRepository {
    
    let database: PurchasesDatabase
    
    init(
        database: PurchasesDatabase = PurchasesDatabaseImpl(database: DatabaseImpl.shared)
    ) {
        self.database = database
    }
    
    func fetchPurchase(by pending: Bool, completion: @escaping (Purchase?) -> Void) {
        completion(database.getPurchase(pending: pending)?.toDomain())
    }
    
    func savePurchase(purchase: Domain.Purchase, completion: @escaping (Result<Domain.Purchase, Error>) -> Void) {
        do {
            try database.save(purchase: purchase.toDatabase())
            completion(.success(purchase))
        } catch {
            completion(.failure(error))
        }
    }
}
