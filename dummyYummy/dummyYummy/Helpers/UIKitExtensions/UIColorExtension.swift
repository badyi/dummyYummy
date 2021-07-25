//
//  UIColorHexExtension.swift
//  dummyYummy
//
//  Created by badyi on 20.06.2021.
//

import UIKit

// Hex extension for UIColor
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        let scanner = Scanner(string: hexString)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        let mask = 0x000000FF
        let red = Int(color >> 16) & mask
        let green = Int(color >> 8) & mask
        let blue = Int(color) & mask

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
