//
//  UIColor+hex.swift
//  
//
//  Created by Jobson Mateus on 19/05/23.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let hex: String = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            alpha: Double(a) / 255
        )
    }
}

// MARK: - Background
extension UIColor {
    static let primaryBackgroundColor: UIColor = UIColor(hex: "F4F4F4")
    static let secondaryBackgroundColor: UIColor = UIColor.white
}

// MARK: - Text
extension UIColor {
    static let primaryText: UIColor = UIColor.black
    static let secondaryText: UIColor = UIColor(hex: "343434")
    static let terciaryText: UIColor = UIColor.white
}

// MARK: - Other
extension UIColor {
    static let primaryColor: UIColor = UIColor(hex: "6618C8")
    static let border: UIColor = UIColor.black.withAlphaComponent(0.1)
    static let shadow: UIColor = UIColor.black
}

