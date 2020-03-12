//
//  BMBottomView+Drag.swift
//  Media Editor
//
//  Created by Baptiste on 12/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

extension BMBottomView: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        itemsForBeginning session: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        
        let option = selectedCustomizationCategory.customizationOptions[indexPath.section]
        let choice = selectedCustomizationCategory.customizationChoices(for: option)[indexPath.row] as? BMStickerCustomization

        guard let image = choice?.image
            else { return [] }
             
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image

        isNewSticker = true

        return [item]
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        dragPreviewParametersForItemAt indexPath: IndexPath)
        -> UIDragPreviewParameters? {

            let previewParameters = UIDragPreviewParameters()
            previewParameters.backgroundColor = UIColor.clear
            return previewParameters
    }
}
