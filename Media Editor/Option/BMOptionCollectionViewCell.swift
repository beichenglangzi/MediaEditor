//
//  BMOptionsPresentationBottomView.swift
//  Media Editor
//
//  Created by Baptiste on 08/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

protocol BMPreparableCollectionViewCell {
    
    func prepare(with choice: BMCustomization)
    var delegate: BMCustomizationDelegate? { get set }
}

/// A collection view cell representing a selectable option item (e.g. Colors)
class BMOptionCollectionViewCell: UICollectionViewCell, BMPreparableCollectionViewCell {

    @IBOutlet weak var optionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let cellId = "BMOptionCollectionViewCell"
    
    weak var delegate: BMCustomizationDelegate?

    override var isSelected: Bool {
        didSet {
            optionImageView.layer.borderWidth = isSelected ? 2 : 1
            optionImageView.layer.borderColor = (isSelected ? UIColor.red : .lightGray).cgColor
            titleLabel.textColor = isSelected ? .red : .black
        }
    }

    func prepare(with choice: BMCustomization) {

        optionImageView.layer.cornerRadius = optionImageView.frame.size.width / 2
        optionImageView.layer.masksToBounds = true
        optionImageView.layer.borderWidth = 1
        optionImageView.layer.borderColor = UIColor.lightGray.cgColor

        if let color = choice as? BMColorCustomization {
            optionImageView.backgroundColor = color.color
        }
        if let _ = choice as? BMSepiaColorCustomization {
            optionImageView.backgroundColor = .sepia
        }
        if choice is BMNoneCustomization {
            optionImageView.image = #imageLiteral(resourceName: "traffic.png")
        }
        if choice is BMEffectCustomization {
            optionImageView.image = #imageLiteral(resourceName: "texture.png")
        }

        titleLabel.text = choice.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        delegate = nil
        optionImageView.image = nil
        optionImageView.backgroundColor = .white
        titleLabel.text = nil
    }
}
