//
//  BMFilter.swift
//  Media Editor
//
//  Created by Baptiste on 10/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

protocol BMCustomization {
    
    var displayStyle: BMDisplayStyle { get }
    
    var coreImageKey: String { get }
    
    var ciValue: Any { get }
    
    var name: String? { get }
}

class BMNoneCustomization: BMCustomization {
        
    var name: String? {
        return "None"
    }
    
    var displayStyle: BMDisplayStyle {
        return .option
    }
    
    var coreImageKey: String {
        return ""
    }
    
    var ciValue: Any {
        return ""
    }
}

enum BMDisplayStyle {
    case option,
    slider,
    draggableItem
    
    var cellId: String {
        switch self {
        case .option:
            return BMOptionCollectionViewCell.cellId
        case .slider:
            return BMSliderCollectionViewCell.cellId
        case .draggableItem:
            return BMDraggableCollectionViewCell.cellId
        }
    }
    
    func displaySize(forContainerSize size: CGSize) -> CGSize {
        switch self {
        case .option:
            return CGSize(width: 50, height: 40)
        case .slider:
            return CGSize(width: size.width, height: 70)
        case .draggableItem:
            return CGSize(width: size.width / 3 - 40, height: 60)
        }
    }
    
    var spacing: CGFloat {
        switch self {
        case .option:
            return 10
        case .slider:
            return 10
        case .draggableItem:
            return 20
        }
    }
}
