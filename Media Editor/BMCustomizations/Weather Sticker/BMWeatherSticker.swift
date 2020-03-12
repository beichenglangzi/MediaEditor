//
//  BMWeatherSticker.swift
//  Media Editor
//
//  Created by Baptiste on 12/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

/// A View representing the sticker
class BMWeatherSticker: UIView, NibLoadable {
    
    var contentView: UIView!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var weatherInfos: BMWeatherInfos? {
        didSet {
            prepareUI(with: weatherInfos)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        contentView = loadNib()
        xibSetup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView = loadNib()
        xibSetup()
    }

    func prepareUI(with infos: BMWeatherInfos?) {
        
        weatherImageView.image = infos?.iconImage
        temperatureLabel.text = infos?.temperatureString
        cityNameLabel.text = infos?.cityName
    }
}
