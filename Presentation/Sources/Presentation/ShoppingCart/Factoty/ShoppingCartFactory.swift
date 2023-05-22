//
//  ShoppingCartFactory.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation
import Domain

public struct ShoppingCartFactory {
    public static func makeViewModel(useCases: PurchasesUseCases) -> ShoppingCartViewModel {
        ShoppingCartViewModelImpl(useCases: useCases)
    }
}
