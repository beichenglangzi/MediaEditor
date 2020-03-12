//
//  BMBottomView.swift
//  Media Editor
//
//  Created by Baptiste on 08/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

let kDefaultCornerRadius: CGFloat = 25

protocol BMBottomViewDelegate: NSObjectProtocol {
    
    func customizationUpdate(_ customization: BMFilter,
                             for category: BMCustomizationCategory)
    func dismissBottomView(animated: Bool)
}

class BMBottomView: UIView, NibLoadable {
    
    var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    
    weak var delegate: BMBottomViewDelegate?
    
    var currentCustomizations: [BMCustomizationCategory: [BMCustomizationType: BMCustomization]] = [:]
    var selectedIndexPath: [BMCustomizationCategory: [BMCustomizationType: IndexPath]] = [:]

    func selectIndexPath(_ indexPath: IndexPath,
                         for type: BMCustomizationType,
                         in category: BMCustomizationCategory) {
        
        if selectedIndexPath[category] == nil {
            selectedIndexPath[category] = [:]
        }
        selectedIndexPath[category]?[type] = indexPath
    }
    
    func selectedIndexPath(for type: BMCustomizationType,
                           in category: BMCustomizationCategory) -> IndexPath? {
        return selectedIndexPath[category]?[type]
    }

    func currentCustomization(for type: BMCustomizationType,
                              in category: BMCustomizationCategory) -> BMCustomization? {
        return currentCustomizations[category]?[type]
    }
    
    func update(customization: BMCustomization,
                for type: BMCustomizationType,
                in category: BMCustomizationCategory) {
            
        if currentCustomizations[category] == nil {
            currentCustomizations[category] = [:]
        }
        currentCustomizations[category]?[type] = customization

        guard let customizations = currentCustomizations[category]?.map({ $1 }),
            let filter = selectedCustomizationCategory.customization(with: customizations)
            else { return }
        
        delegate?.customizationUpdate(filter, for: selectedCustomizationCategory)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        contentView = loadNib()
        xibSetup()

        prepareUI()
    }
    
    @IBAction func panAction() {
        if panGesture.velocity(in: self).y > 0 {
            doneAction()
        }
    }
    
    var allCustomizationCategories: [BMCustomizationCategory] = [.filters, .effects, .adjust, .stickers]
    var selectedCustomizationCategory: BMCustomizationCategory = .filters
    
    init() {
        super.init(frame: CGRect.zero)
        
        contentView = loadNib()
        xibSetup()

        prepareUI()
    }

    func prepareUI() {
                
        contentView.layer.cornerRadius = kDefaultCornerRadius
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        
        optionsCollectionView.register(UINib.init(nibName: "BMOptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BMOptionCollectionViewCell.cellId)
        
        optionsCollectionView.register(UINib.init(nibName: "BMSliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BMSliderCollectionViewCell.cellId)

        optionsCollectionView.register(UINib.init(nibName: "BMDraggableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BMDraggableCollectionViewCell.cellId)

        optionsCollectionView.delegate = self
        optionsCollectionView.dataSource = self
        optionsCollectionView.dragDelegate = self
        optionsCollectionView.dragInteractionEnabled = true
        
        optionsCollectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        selectIndexPath(IndexPath(row: 0, section: 0), for: .style, in: .filters)
        selectIndexPath(IndexPath(row: 0, section: 0), for: .style, in: .effects)
        customizationUpdate(BMNoneCustomization(), for: .style)
        
        categoriesCollectionView.register(UINib.init(nibName: "BMCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BMCategoryCollectionViewCell.cellId)
                
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        let idx = allCustomizationCategories.firstIndex(of: selectedCustomizationCategory) ?? 0
        categoriesCollectionView.selectItem(at: IndexPath(row: idx, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        
        categoriesCollectionView.contentInset.left = 20
        categoriesCollectionView.contentInset.right = 20
    }
    
    @IBAction func doneAction() {
        delegate?.dismissBottomView(animated: true)
    }
}
