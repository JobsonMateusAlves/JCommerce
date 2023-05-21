//
//  PurchaseRepository.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation
import Domain

public final class PurchasesRepositoryImpl: Domain.PurchasesRepository {
    
    let database: PurchasesDatabase
    
    public init(
        database: PurchasesDatabase = PurchasesDatabaseImpl(database: Database.shared)
    ) {
        self.database = database
    }
    
    public func fetchPurchase(by pending: Bool, completion: @escaping (Purchase?) -> Void) {
        completion(database.getPurchase(pending: pending)?.toDomain())
    }
    
    public func savePurchase(purchase: Domain.Purchase, completion: @escaping (Result<Domain.Purchase, Error>) -> Void) {
        do {
            try database.save(purchase: purchase.toDatabase())
            completion(.success(purchase))
        } catch {
            completion(.failure(error))
        }
    }
}