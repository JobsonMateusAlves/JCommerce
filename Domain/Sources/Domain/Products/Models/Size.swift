//
//  Size.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

public struct Size {
    public var available: Bool
    public var size: String
    public var sku: String
    
    public init(available: Bool, size: String, sku: String) {
        self.available = available
        self.size = size
        self.sku = sku
    }
}
