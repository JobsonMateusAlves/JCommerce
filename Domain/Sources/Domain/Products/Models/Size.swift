//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

public struct Size {
    var available: Bool
    var size: String
    var sku: String
    
    public init(available: Bool, size: String, sku: String) {
        self.available = available
        self.size = size
        self.sku = sku
    }
}
