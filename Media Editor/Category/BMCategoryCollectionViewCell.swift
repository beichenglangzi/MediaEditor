//
//  BMCategoryCollectionViewCell.swift
//  Media Editor
//
//  Created by Baptiste on 10/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

class BMCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    static let cellId = "BMCategoryCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor(hex: 0xEEEEEE) : .white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
//        layer.shadowColor = UIColor.gray.cgColor
//        layer.shadowOpacity = 0.3
//        layer.shadowRadius = 5
//        layer.masksToBounds = false
    }
    
    func prepare(with category: BMCustomizationCategory) {
        
        categoryImageView.image = category.logo
        categoryNameLabel.text = category.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryImageView.image = nil
        categoryNameLabel.text = nil
    }
}
