//
//  File.swift
//  
//
//  Created by Jobson Mateus on 17/05/23.
//

import Foundation

struct Product: Codable {
    var name: String
    var style: String
    var code_color: String
    var color_slug: String
    var color: String
    var on_sale: Bool
    var regular_price: String
    var actual_price: String
    var discount_percentage: String
    var installments: String
    var image: String
    var sizes: [Size]
}
