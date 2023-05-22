//
//  API.swift
//  
//
//  Created by Jobson Mateus on 16/05/23.
//

import Foundation

/// HTTP Methods
enum HTTPMethod: String {
   case GET
   case POST
   case DELETE
   case PUT
}

protocol API {
    
    var url: String { get }
    
    var method: HTTPMethod { get }
    
    var data: Codable? { get }
    
    var parameters: [String: Any]? { get }
    
    var headers: [String: String]? { get }
}
