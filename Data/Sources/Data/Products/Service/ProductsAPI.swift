//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

public enum ProductsAPI {
    case fetchProducts
}

extension ProductsAPI: API {
    public var url: String {
        "http://www.mocky.io/v2/59b6a65a0f0000e90471257d"
    }
    
    public var method: HTTPMethod {
        .GET
    }
    
    public var data: Codable? {
        nil
    }
    
    public var parameters: [String : Any]? {
        nil
    }
    
    public var headers: [String : String]? {
        nil
    }
}
