//
//  BMTextInputCollectionViewCell.swift
//  Media Editor
//
//  Created by Baptiste on 10/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

/// A collection view cell representing a text item
class BMTextInputCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editAction() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
