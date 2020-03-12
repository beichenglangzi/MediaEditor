//
//  BMDraggableCollectionViewCell.swift
//  Media Editor
//
//  Created by Baptiste on 11/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

class BMDraggableCollectionViewCell: UICollectionViewCell, BMPreparableCollectionViewCell {
        
    @IBOutlet weak var imageView: UIImageView!
    
    static let cellId = "BMDraggableCollectionViewCell"
    
    var delegate: BMCustomizationDelegate?

    func prepare(with choice: BMCustomization) {
        
        if let sticker = choice as? BMStickerCustomization {
            imageView.image = sticker.image
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.image = nil
    }
}
