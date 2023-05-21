//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

struct Size: Codable {
    var available: Bool
    var size: String
    var sku: String
}

extension Size {
    func toDatabase() -> SizeObject {
        SizeObject(
            sku: sku,
            available: available,
            size: size
        )
    }
}
