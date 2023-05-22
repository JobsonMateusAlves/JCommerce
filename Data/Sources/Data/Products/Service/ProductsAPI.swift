//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

enum ProductsAPI {
    case fetchProducts
}

extension ProductsAPI: API {
    var url: String {
        "http://www.mocky.io/v2/59b6a65a0f0000e90471257d"
    }
    
    var method: HTTPMethod {
        .GET
    }
    
    var data: Codable? {
        nil
    }
    
    var parameters: [String : Any]? {
        nil
    }
    
    var headers: [String : String]? {
        nil
    }
}
