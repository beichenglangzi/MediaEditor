//
//  UIView+Nib.swift
//  Media Editor
//
//  Created by Baptiste on 08/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadable {

    var contentView: UIView! { get set }

    func loadNib() -> UIView
    func xibSetup()
}

extension NibLoadable where Self: UIView {
    
    func loadNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func xibSetup() {

        backgroundColor = UIColor.clear

        contentView.frame = bounds
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": contentView as Any]))
                
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": contentView as Any]))
    }
}
