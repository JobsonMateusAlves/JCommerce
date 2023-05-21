//
//  Purchase+Extension.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation
import Domain
import RealmSwift

extension Purchase {
    func toDatabase() -> PurchaseObject {
        let itemsList: List<ProductItemObject> = List<ProductItemObject>()
        itemsList.append(objectsIn: items.map({ $0.toDatabase() }))
        
        return PurchaseObject(
            id: id,
            items: itemsList,
            pending: pending
        )
    }
}
