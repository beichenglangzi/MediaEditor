//
//  BMEffectCustomization.swift
//  Media Editor
//
//  Created by Baptiste on 11/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation

class BMEffectCustomization: BMCustomization {
   
    enum BMEffect: String {
        case chrome = "CIPhotoEffectChrome",
        fade = "CIPhotoEffectFade",
        instant = "CIPhotoEffectInstant",
        mono = "CIPhotoEffectMono",
        noir = "CIPhotoEffectNoir",
        process = "CIPhotoEffectProcess",
        tonal = "CIPhotoEffectTonal",
        transfer = "CIPhotoEffectTransfer",
        invert = "CIColorInvert"
    }
    
    var name: String? {
        switch effect {
        case .chrome:
            return "Chrome"
        case .fade:
            return "Fade"
        case .instant:
            return "Instant"
        case .mono:
            return "Mono"
        case .noir:
            return "Noir"
        case .process:
            return "Process"
        case .tonal:
            return "Tonal"
        case .transfer:
            return "Transfer"
        case .invert:
            return "Invert"
        }
    }

    var effect: BMEffect
    
    init(_ effect: BMEffect) {
        self.effect = effect
    }

    var displayStyle: BMDisplayStyle {
        return .option
    }
    
    var coreImageKey: String {
        return BMEffectsFilter.requiredKeys.first ?? ""
    }
    
    var ciValue: Any {
        return effect.rawValue
    }
}
