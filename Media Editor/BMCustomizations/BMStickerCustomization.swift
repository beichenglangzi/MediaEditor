//
//  BMStickerCustomization.swift
//  Media Editor
//
//  Created by Baptiste on 11/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

class BMStickerCustomization: BMCustomization {
           
    var image: UIImage

    init(_ image: UIImage) {
        self.image = image
    }
    
    var name: String? {
        return nil
    }
    
    var displayStyle: BMDisplayStyle {
        return .draggableItem
    }
    
    var coreImageKey: String {
        return kCIInputImageKey
    }
    
    var ciValue: Any {
        return CIImage(image: image) as Any
    }
}

class BMWeatherStickerCustomization: BMStickerCustomization {
    
    init() {
        let stc = BMWeatherDataManager.default.weatherForLastLocation?.stickerImage
        super.init(stc ?? #imageLiteral(resourceName: "02d"))
    }
}
