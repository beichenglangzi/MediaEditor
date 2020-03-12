//
//  BMColorCustomization.swift
//  Media Editor
//
//  Created by Baptiste on 11/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

class BMColorCustomization: BMCustomization {
    
    var color: UIColor
    var _desc: String?
    
    init(_ color: UIColor, _ desc: String? = nil) {
        self.color = color
        self._desc = desc
    }

    var name: String? {
        return _desc
    }
    
    var displayStyle: BMDisplayStyle {
        return .option
    }
    
    var coreImageKey: String {
        return kCIInputColorKey
    }
    
    var ciValue: Any {
        return CIColor(color: color)
    }
}

class BMSepiaColorCustomization: BMCustomization {
    
    var name: String? {
        return "Sepia"
    }
    
    var displayStyle: BMDisplayStyle {
        return .option
    }
    
    var coreImageKey: String {
        return ""
    }
    
    var ciValue: Any {
        return "__SEPIA__"
    }
}
