//
//  BMHomeViewController+DragDrop.swift
//  Media Editor
//
//  Created by Baptiste on 11/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

// Moving an existing sticker
extension BMHomeViewController: UIDragInteractionDelegate {
        
    func dragInteraction(_ interaction: UIDragInteraction,
                         itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        let imgv = interaction.view as? UIImageView
        
        guard let image = imgv?.image
            else { return [] }

        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        item.localObject = image

        return [item]
    }
    
    func dragInteraction(_ interaction: UIDragInteraction,
                         previewForLifting item: UIDragItem,
                         session: UIDragSession) -> UITargetedDragPreview? {
        
        guard let view = interaction.view
            else { return nil }
        
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = UIColor.clear

        let target = UITargetedDragPreview.init(view: view,
                                                parameters: previewParameters)

        return target
    }
    
    func dragInteraction(_ interaction: UIDragInteraction,
                         session: UIDragSession,
                         willEndWith operation: UIDropOperation) {

        interaction.view?.removeFromSuperview()
    }
}

extension BMHomeViewController: UIDropInteractionDelegate {

    func dropInteraction(_ interaction: UIDropInteraction,
                         sessionDidUpdate session: UIDropSession) -> UIDropProposal {

        let operation: UIDropOperation = session.localDragSession == nil && isNewSticker ? .copy : .move
        return UIDropProposal(operation: operation)
    }

    func dropInteraction(_ interaction: UIDropInteraction,
                         performDrop session: UIDropSession) {

        isNewSticker = false
        
        session.loadObjects(ofClass: UIImage.self) { imageItems in
       
            let image = imageItems.first as! UIImage
        
            let dropLocation = session.location(in: self.stickersWhiteBoardView)

            let w: CGFloat = kStickersDefaultSize
            let size = CGSize(width: w,
                              height: w * image.size.height / image.size.width)
            let origin = CGPoint.init(x: dropLocation.x - size.width / 2,
                                  y: dropLocation.y - size.height / 2)
        
            let imgv = UIImageView(frame: CGRect(origin: origin, size: size))
            imgv.image = image
            
            let dragInteraction = UIDragInteraction(delegate: self)
            dragInteraction.isEnabled = true
            imgv.addInteraction(dragInteraction)
            imgv.isUserInteractionEnabled = true
            
            self.stickersWhiteBoardView.addSubview(imgv)
        }
    }
}
