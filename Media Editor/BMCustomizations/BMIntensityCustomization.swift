//
//  BMIntensityCustomization.swift
//  Media Editor
//
//  Created by Baptiste on 11/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

class BMIntensityCustomization: BMCustomization {

    var minimumIntensity: Float
    var maximumIntensity: Float
    var currentIntensity: Float
    
    var relatedType: BMCustomizationType
    
    init(min: Float, max: Float, def: Float, relatedType: BMCustomizationType) {
        self.minimumIntensity = min
        self.maximumIntensity = max
        self.currentIntensity = def

        self.relatedType = relatedType
    }
    
    var name: String? {
        return relatedType.displayName
    }

    var displayStyle: BMDisplayStyle {
        return .slider
    }
    
    var coreImageKey: String {
        return relatedType.linkedCiKey ?? kCIInputIntensityKey
    }
    
    var ciValue: Any {
        return NSNumber(value: currentIntensity)
    }
}
