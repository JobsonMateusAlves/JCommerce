//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation
import Domain

struct Size: Codable {
    var available: Bool
    var size: String
    var sku: String
}

extension Size {
    func toDomain() -> Domain.Size {
        Domain.Size(
            available: available,
            size: size,
            sku: sku
        )
    }
    
    func toDatabase() -> SizeObject {
        SizeObject(
            sku: sku,
            available: available,
            size: size
        )
    }
}
