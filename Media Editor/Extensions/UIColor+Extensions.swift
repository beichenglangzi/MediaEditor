//
//  UIColor+Extensions.swift
//  Media Editor
//
//  Created by Baptiste on 10/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class var sepia: UIColor {
        return UIColor(hex: 0x704214)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }
}

extension UIColor {
    
    class var appleRed: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 59.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
    }
    class var appleOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 149.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    class var appleYellow: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 204.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    class var appleGreen: UIColor {
        return UIColor(red: 76.0 / 255.0, green: 217.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
    }
    class var appleTealBlue: UIColor {
        return UIColor(red: 90.0 / 255.0, green: 200.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
    class var appleBlue: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    class var applePurple: UIColor {
        return UIColor(red: 88.0 / 255.0, green: 86.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }
    class var applePink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 45.0 / 255.0, blue: 85.0 / 255.0, alpha: 1.0)
    }
}
