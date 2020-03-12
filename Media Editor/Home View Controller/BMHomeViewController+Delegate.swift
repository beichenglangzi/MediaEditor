//
//  BMHomeViewController+Delegate.swift
//  Media Editor
//
//  Created by Baptiste on 12/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation

extension BMHomeViewController: BMBottomViewDelegate {
   
    func customizationUpdate(_ customization: BMFilter,
                             for category: BMCustomizationCategory) {
        
        BMCustomizationManager.shared.allFilters[category] = customization
        
        let allFilters = BMCustomizationManager.shared.allFilters.map { $1 }
        
        guard let img = BMCustomizationManager.shared.initialImage
            else { return }
        
        BMCustomizationManager.shared.render(image: img, with: allFilters) { (image) in
            BMCustomizationManager.shared.filteredImage = image
            self.mediaRenderedImageView.image = image
        }
    }
    
    func dismissBottomView(animated: Bool = true) {
        showEditMenu(false, animated: animated)
    }
}
