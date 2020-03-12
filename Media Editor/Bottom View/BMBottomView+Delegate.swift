//
//  BMBottomView+Delegate.swift
//  Media Editor
//
//  Created by Baptiste on 10/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

extension BMBottomView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
                
        if collectionView == categoriesCollectionView {
            selectedCustomizationCategory = allCustomizationCategories[indexPath.row]
            optionsCollectionView.reloadData()
            return
        }
        
        let type = selectedCustomizationCategory.customizationOptions[indexPath.section]
        let choice = selectedCustomizationCategory.customizationChoices(for: type)[indexPath.row]

        customizationUpdate(choice, for: type)
        selectIndexPath(indexPath, for: type, in: selectedCustomizationCategory)
        
        collectionView.reloadData()
    }
}

extension BMBottomView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoriesCollectionView {
            return CGSize(width: 110, height: 35)
        }
        
        let option = selectedCustomizationCategory.customizationOptions[indexPath.section]
        return option.displayStyle.displaySize(forContainerSize: collectionView.frame.size)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == categoriesCollectionView {
            return 10
        }

        let option = selectedCustomizationCategory.customizationOptions[section]
        return option.displayStyle.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == categoriesCollectionView {
            return 10
        }
        
        let option = selectedCustomizationCategory.customizationOptions[section]
        return option.displayStyle.spacing
    }
}
