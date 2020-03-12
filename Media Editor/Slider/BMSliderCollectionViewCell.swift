//
//  BMSliderCollectionViewCell.swift
//  Media Editor
//
//  Created by Baptiste on 10/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

class BMSliderCollectionViewCell: UICollectionViewCell, BMPreparableCollectionViewCell {
    
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let cellId = "BMSliderCollectionViewCell"
        
    var intensity: BMIntensityCustomization?
    
    weak var delegate: BMCustomizationDelegate?
    
    var lastValue: Float = -1
    
    func prepare(with choice: BMCustomization) {
                
        if let intensity = choice as? BMIntensityCustomization {
            
            self.intensity = intensity

            minValueLabel.text = String(format: "%0.2f", intensity.minimumIntensity)
            maxValueLabel.text = String(format: "%0.2f", intensity.maximumIntensity)
            currentValueLabel.text = String(format: "%0.2f", intensity.currentIntensity)
            slider.value = intensity.currentIntensity
            titleLabel.text = intensity.name
            
            slider.minimumValue = intensity.minimumIntensity
            slider.maximumValue = intensity.maximumIntensity
            let img = UIImage.makeCircleOf(size: CGSize(width: 15, height: 15), color: UIColor.darkGray)
            slider.setThumbImage(img, for: .normal)
        }
    }

    @IBAction func sliderValueChanged() {

        let interval: Float = 0.05
        let newValue = interval * floor((slider.value / interval) + 0.005)
        slider.setValue(newValue, animated: false)

        guard let intensity = self.intensity,
            lastValue != newValue
            else { return }
        
        lastValue = newValue
        
        intensity.currentIntensity = slider.value
        currentValueLabel.text = String(format: "%0.2f", intensity.currentIntensity)
        delegate?.customizationUpdate(intensity, for: intensity.relatedType)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        delegate = nil
        
        minValueLabel.text = nil
        maxValueLabel.text = nil
        currentValueLabel.text = nil
    }
}
