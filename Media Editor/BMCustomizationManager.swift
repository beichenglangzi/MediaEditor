//
//  BMCustomizationManager.swift
//  Media Editor
//
//  Created by Baptiste on 10/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

class BMCustomizationManager: NSObject {
    
    static let _instance  = BMCustomizationManager()
    
    class var `shared`: BMCustomizationManager {
        return _instance
    }
        
    var imageContext: CIContext = CIContext()
    
    var initialImage: UIImage?
    var filteredImage: UIImage?
    var editedCategory: BMCustomizationCategory = .effects
    var allFilters = [BMCustomizationCategory: BMFilter]()
    
    var customizedImageWithoutCurrentlyEditedFilter: CIImage? {
        return nil
    }
    
    var editedFilter: BMFilter? {
        return allFilters[editedCategory]
    }

    func render(image: UIImage,
                with customizations: [BMFilter],
                completion: @escaping (UIImage?) -> Void) {

        func completionMainThread(with image: UIImage?) {
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        DispatchQueue.global(qos: .default).async {
            
            guard let cgImage = image.cgImage
                else {
                    completionMainThread(with: nil)
                    return
            }
            
            var processedImage: CIImage = CIImage(cgImage: cgImage)

            customizations.forEach { (customization) in
                if let customizedImage = customization.applied(to: processedImage) {
                    processedImage = customizedImage
                }
            }
            
            guard let cgImg = self.imageContext.createCGImage(processedImage, from: processedImage.extent)
                else {
                    completionMainThread(with: nil)
                    return
            }
                
            let renderedImage = UIImage(cgImage: cgImg)
            completionMainThread(with: renderedImage)
        }
    }
    
    private override init() {}
}

