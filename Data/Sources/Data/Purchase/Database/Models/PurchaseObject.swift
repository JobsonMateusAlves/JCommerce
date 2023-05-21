//
//  PurchaseObject.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import RealmSwift
import Domain

public class PurchaseObject: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var items: List<ProductItemObject> = List<ProductItemObject>()
    @Persisted var pending: Bool = true
    
    convenience init(id: String, items: List<ProductItemObject>, pending: Bool) {
        self.init()
        self.id = id
        self.items = items
        self.pending = pending
    }
}

extension PurchaseObject {
    func toDomain() -> Domain.Purchase {
        Domain.Purchase(
            id: id,
            items: items.map({ $0.toDomain() }),
            pending: pending
        )
    }
}

