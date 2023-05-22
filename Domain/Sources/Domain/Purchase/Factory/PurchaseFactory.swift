//
//  PurchaseFactory.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation

public struct PurchaseFactory {
    public static func makeUseCase(repository: PurchasesRepository) -> PurchasesUseCases {
        PurchasesUseCasesImpl(repository: repository)
    }
}
