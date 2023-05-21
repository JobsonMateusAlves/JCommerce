//
//  SizeObject.swift
//  
//
//  Created by Jobson Mateus on 20/05/23.
//

import Foundation
import RealmSwift

public class SizeObject: Object {
    @Persisted(primaryKey: true) var sku: String = ""
    @Persisted var available: Bool = false
    @Persisted var size: String = ""
    
    convenience init(sku: String, available: Bool, size: String) {
        self.init()
        self.sku = sku
        self.available = available
        self.size = size
    }
}
