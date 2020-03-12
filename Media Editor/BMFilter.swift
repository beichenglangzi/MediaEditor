//
//  BMFilter.swift
//  Media Editor
//
//  Created by Baptiste on 11/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

protocol BMFilter {
    
    var parentType: BMCustomizationCategory { get }
    
    var preview: UIImage { get }
    var filter: CIFilter { get }
    
    var emptyFilter: Bool { get set }
    
    func add(choice: BMCustomization)
    func applied(to image: CIImage) -> CIImage?
}

class BMColorFilter: BMFilter {
    
    static let requiredKeys = [kCIInputColorKey, kCIInputIntensityKey]
        
    var choices = [String: Any]()

    var isSepia: Bool = false
    
    var emptyFilter: Bool = false
    
    func add(choice: BMCustomization) {

        if choice is BMNoneCustomization {
            emptyFilter = true
        }
        
        if choice is BMColorCustomization {
            isSepia = false
        }

        if choice is BMSepiaColorCustomization {
            isSepia = true
            choices.removeValue(forKey: kCIInputColorKey)
            return
        }
        
        guard Self.requiredKeys.contains(choice.coreImageKey)
            else { return }

        choices[choice.coreImageKey] = choice.ciValue
    }
  
    init(choices: [BMCustomization]) {

        choices.forEach({
            add(choice: $0)
        })
    }
    
    var parentType: BMCustomizationCategory {
        return .filters
    }
    
    var preview: UIImage {
        UIImage()
    }
    
    var filter: CIFilter {
        return CIFilter.init()
    }
    
    func applied(to image: CIImage) -> CIImage? {

        guard !emptyFilter
            else { return image }

        var parameters = choices
        parameters[kCIInputImageKey] = image

        let filterName = isSepia ? "CISepiaTone" : "CIColorMonochrome"
        let filter = CIFilter(name: filterName,
                              parameters: parameters)

        return filter?.outputImage
    }
}

class BMStickerFilter: BMFilter {
    
    static let requiredKeys = [kCIInputImageKey]
        
    var choices = [String: Any]()
    
    var emptyFilter: Bool = false
    
    func add(choice: BMCustomization) {

        if choice is BMNoneCustomization {
            emptyFilter = true
        }

        guard Self.requiredKeys.contains(choice.coreImageKey)
            else { return }

        choices[kCIInputImageKey] = choice.ciValue
    }
  
    init(choices: [BMCustomization]) {

        choices.forEach({
            add(choice: $0)
        })
    }
    
    var parentType: BMCustomizationCategory {
        return .stickers
    }
    
    var preview: UIImage {
        UIImage()
    }
    
    var filter: CIFilter {
        return CIFilter.init()
    }
    
    func applied(to image: CIImage) -> CIImage? {

        var parameters = choices
        parameters[kCIInputBackgroundImageKey] = image

        let filter = CIFilter(name: "CISourceOverCompositing",
                              parameters: parameters)

        return filter?.outputImage
    }
}

class BMEffectsFilter: BMFilter {
    
    static let requiredKeys = ["__EFFECT_NAME__"]
        
    var ciEffectName: String?

    var emptyFilter: Bool = false
    
    func add(choice: BMCustomization) {

        if choice is BMNoneCustomization {
            emptyFilter = true
        }

        guard Self.requiredKeys.contains(choice.coreImageKey)
            else { return }

        ciEffectName = choice.ciValue as? String
    }
  
    init(choices: [BMCustomization]) {

        choices.forEach({
            add(choice: $0)
        })
    }
    
    var parentType: BMCustomizationCategory {
        return .filters
    }
    
    var preview: UIImage {
        UIImage()
    }
    
    var filter: CIFilter {
        return CIFilter.init()
    }
    
    func applied(to image: CIImage) -> CIImage? {

        guard let ciEffectName = ciEffectName,
            !emptyFilter
            else { return image }
        
        let parameters = [kCIInputImageKey: image]
        let filter = CIFilter(name: ciEffectName,
                              parameters: parameters)
        return filter?.outputImage
    }
}

class BMAdjustmentFilter: BMFilter {
    
    static let requiredKeys = [kCIInputSaturationKey,
                               kCIInputBrightnessKey,
                               kCIInputContrastKey]

    var choices = [String: Any]()
    
    var emptyFilter: Bool = false
    
    func add(choice: BMCustomization) {

        if choice is BMNoneCustomization {
            emptyFilter = true
        }
        
        guard Self.requiredKeys.contains(choice.coreImageKey)
            else { return }

        choices[choice.coreImageKey] = choice.ciValue
    }
  
    init(choices: [BMCustomization]) {

        choices.forEach({
            add(choice: $0)
        })
    }
    
    var parentType: BMCustomizationCategory {
        return .filters
    }
    
    var preview: UIImage {
        UIImage()
    }
    
    var filter: CIFilter {
        return CIFilter.init()
    }
    
    func applied(to image: CIImage) -> CIImage? {

        guard !emptyFilter
            else { return image }

        var parameters = choices
        parameters[kCIInputImageKey] = image

        let filterName = "CIColorControls"
        let filter = CIFilter(name: filterName,
                              parameters: parameters)

        return filter?.outputImage
    }
}

