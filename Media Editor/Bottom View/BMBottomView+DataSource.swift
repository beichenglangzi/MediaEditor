//
//  BMBottomView+DataSource.swift
//  Media Editor
//
//  Created by Baptiste on 10/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

extension BMBottomView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == categoriesCollectionView {
            return 1
        }
        return selectedCustomizationCategory.customizationOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
            
        if collectionView == categoriesCollectionView {
            return allCustomizationCategories.count
        }

        let option = selectedCustomizationCategory.customizationOptions[section]
        return selectedCustomizationCategory.customizationChoices(for: option).count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesCollectionView {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BMCategoryCollectionViewCell.cellId, for: indexPath) as! BMCategoryCollectionViewCell

            let category = allCustomizationCategories[indexPath.row]
            cell.prepare(with: category)
            
            return cell
        }
        
        let displayStyle = selectedCustomizationCategory.customizationOptions[indexPath.section].displayStyle
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: displayStyle.cellId, for: indexPath)

        let option = selectedCustomizationCategory.customizationOptions[indexPath.section]
        
        let savedChoice = self.currentCustomization(for: option, in: self.selectedCustomizationCategory)

        let choice: BMCustomization
            = (option.displayStyle == .slider ? savedChoice : nil)
                ?? selectedCustomizationCategory.customizationChoices(for: option)[indexPath.row]
        
        if var cell = cell as? BMPreparableCollectionViewCell {
            cell.prepare(with: choice)
            cell.delegate = self
        }
        
        if selectedIndexPath(for: option, in: selectedCustomizationCategory) == indexPath {
            cell.isSelected = true
        }
        
        return cell
    }    
}

extension BMBottomView: BMCustomizationDelegate {
    
    func customizationUpdate(_ choice: BMCustomization,
                             for type: BMCustomizationType) {
        update(customization: choice, for: type, in: selectedCustomizationCategory)
    }
}
