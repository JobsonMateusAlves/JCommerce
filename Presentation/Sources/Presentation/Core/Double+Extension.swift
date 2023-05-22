//
//  File.swift
//  
//
//  Created by Jobson Mateus on 22/05/23.
//

import Foundation

extension Double {
    func toString(with maximumFractionDigits: Int = 2) -> String {
        return  String(format: "%.2f", self)
    }
}
