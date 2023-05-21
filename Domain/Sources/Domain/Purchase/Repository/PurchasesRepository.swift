//
//  PurchaseRepository.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation

public protocol PurchasesRepository {
    func fetchPurchase(by pending: Bool, completion: @escaping (Purchase?) -> Void)
    func savePurchase(purchase: Purchase, completion: @escaping (Result<Purchase, Error>) -> Void)
}
