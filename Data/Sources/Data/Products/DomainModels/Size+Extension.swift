//
//  File.swift
//  
//
//  Created by Jobson Mateus on 21/05/23.
//

import Foundation
import Domain
import RealmSwift

extension Domain.Size {
    func toDatabase() -> SizeObject {
        SizeObject(
            sku: sku,
            available: available,
            size: size
        )
    }
}
