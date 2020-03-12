//
//  BMCustomization+Category.swift
//  Media Editor
//
//  Created by Baptiste on 11/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

/// Configuration of the Customization Interface
enum BMCustomizationType {
    case style,
    intensity,
    saturation,
    brightness,
    contrast,
    additionalItem

    var displayStyle: BMDisplayStyle {
        switch self {
        case .style:
            return .option
        case .intensity, .saturation, .brightness, .contrast:
            return .slider
        case .additionalItem:
            return .draggableItem
        }
    }
    
    var linkedCiKey: String? {
        switch self {
        case .intensity:
            return kCIInputIntensityKey
        case .saturation:
            return kCIInputSaturationKey
        case .brightness:
            return kCIInputBrightnessKey
        case .contrast:
            return kCIInputContrastKey
        default:
            return nil
        }
    }
    
    var displayName: String? {
        switch self {
        case .intensity:
            return "Intensity"
        case .saturation:
            return "Saturation"
        case .brightness:
            return "Brightness"
        case .contrast:
            return "Contrast"
        default:
            return nil
        }
    }
}

enum BMCustomizationCategory {
    case filters,
    effects,
    adjust,
    stickers
        
    var customizationOptions: [BMCustomizationType] {
        switch self {
        case .filters:
            return [.style, .intensity]
        case .effects:
            return [.style]
        case .adjust:
            return [.saturation, .brightness, .contrast]
        case .stickers:
            return [.additionalItem]
        }
    }
    
    func customization(with choices: [BMCustomization]) -> BMFilter? {
        switch self {
        case .filters:
            return BMColorFilter(choices: choices)
        case .effects:
            return BMEffectsFilter(choices: choices)
        case .adjust:
            return BMAdjustmentFilter(choices: choices)
        case .stickers:
            return nil
        }
        
    }

    func customizationChoices(for option: BMCustomizationType) -> [BMCustomization] {
        return self.customizationChoices[option] ?? []
    }
    
    var customizationChoices
        : [BMCustomizationType: [BMCustomization]] {
        
        switch self {
        case .filters:
            return [
                BMCustomizationType.style: [
                    BMNoneCustomization(),
                    BMColorCustomization(.white, "White"),
                    BMColorCustomization(.black, "Black"),
                    BMSepiaColorCustomization(),
                    BMColorCustomization(.appleRed, "Red"),
                    BMColorCustomization(.appleOrange, "Orange"),
                    BMColorCustomization(.appleYellow, "Yellow"),
                    BMColorCustomization(.appleGreen, "Green"),
                    BMColorCustomization(.appleTealBlue, "Teal"),
                    BMColorCustomization(.appleBlue, "Blue"),
                    BMColorCustomization(.applePurple, "Purple"),
                    BMColorCustomization(.applePink, "Pink")
                ],
                BMCustomizationType.intensity: [
                    BMIntensityCustomization(min: 0, max: 1, def: 0.5, relatedType: .intensity)
                ]
            ]
        case .effects:
            return [
                BMCustomizationType.style: [
                    BMNoneCustomization(),
                    BMEffectCustomization(.chrome),
                    BMEffectCustomization(.fade),
                    BMEffectCustomization(.instant),
                    BMEffectCustomization(.invert),
                    BMEffectCustomization(.mono),
                    BMEffectCustomization(.noir),
                    BMEffectCustomization(.process),
                    BMEffectCustomization(.tonal),
                    BMEffectCustomization(.transfer)
                ]
            ]
        case .adjust:
            return [
                BMCustomizationType.saturation: [
                    BMIntensityCustomization(min: 0, max: 1, def: 1, relatedType: .saturation)
                ],
                BMCustomizationType.brightness: [
                    BMIntensityCustomization(min: 0, max: 1, def: 0, relatedType: .brightness)
                ],
                BMCustomizationType.contrast: [
                    BMIntensityCustomization(min: 0, max: 1, def: 1, relatedType: .contrast)
                ]
            ]
        case .stickers:
            return [
                BMCustomizationType.additionalItem: [
                    BMStickerCustomization(#imageLiteral(resourceName: "zenly")),
                    BMStickerCustomization(#imageLiteral(resourceName: "champagne")),
                    BMStickerCustomization(#imageLiteral(resourceName: "meat")),
                    BMStickerCustomization(#imageLiteral(resourceName: "canoe")),
                    BMStickerCustomization(#imageLiteral(resourceName: "party")),
                    BMStickerCustomization(#imageLiteral(resourceName: "party-2")),
                    BMStickerCustomization(#imageLiteral(resourceName: "gift")),
                    BMStickerCustomization(#imageLiteral(resourceName: "like")),
                    BMStickerCustomization(#imageLiteral(resourceName: "star")),
                    BMStickerCustomization(#imageLiteral(resourceName: "fun.png")),
                    BMStickerCustomization(#imageLiteral(resourceName: "medal-2")),
                    BMStickerCustomization(#imageLiteral(resourceName: "toy")),
                    BMWeatherStickerCustomization()                    
                ]
            ]
        }
    }
    
    var logo: UIImage {
        switch self {
        case .filters:
            return #imageLiteral(resourceName: "color-circle")
        case .effects:
            return #imageLiteral(resourceName: "effect")
        case .adjust:
            return #imageLiteral(resourceName: "adjust")
        case .stickers:
            return #imageLiteral(resourceName: "sticker")
        }
    }
    
    var name: String {
        switch self {
        case .filters:
            return "Filters"
        case .effects:
            return "Effects"
        case .adjust:
            return "Adjust"
        case .stickers:
            return "Stickers"
        }
    }
    
    static var `default`: BMCustomizationCategory {
        return .filters
    }
}
