//
//  File.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation

public class Purchase {
    public var id: String
    public var items: [ProductItem]
    public var pending: Bool
    
    public init(id: String, items: [ProductItem], pending: Bool) {
        self.id = id
        self.items = items
        self.pending = pending
    }
}

