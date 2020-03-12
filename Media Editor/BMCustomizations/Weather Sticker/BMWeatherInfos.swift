//
//  BMWeatherInfos.swift
//  Media Editor
//
//  Created by Baptiste on 12/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

/// A type representing weather informations for the sticker.
struct BMWeatherInfos {
    
    var weatherName: String
    var weatherIcon: String
    var temperature: Double
    var cityName: String
    
    var iconImage: UIImage? {
        return UIImage(named: "\(weatherIcon)")
    }
    
    var temperatureString: String {
        let m = Measurement(value: temperature, unit: UnitTemperature.kelvin)
        let formatter = MeasurementFormatter()
        return formatter.string(from: m)
    }
    
    func generateStickerView() -> UIView {
        let sticker = BMWeatherSticker(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        sticker.weatherInfos = self
        return sticker
    }
    
    var stickerImage: UIImage?
    
    init?(json: [String: AnyObject]) {
        
        guard let _weatherInfos = json["weather"] as? [[String: AnyObject]],
            let wName = _weatherInfos.first?["main"] as? String,
            let wIcon = _weatherInfos.first?["icon"] as? String,
            let _weatherMain = json["main"] as? [String: AnyObject],
            let wTemperature = _weatherMain["temp"] as? Double,
            let wCityName = json["name"] as? String
            else { return nil }

        weatherName = wName
        weatherIcon = wIcon
        temperature = wTemperature
        cityName = wCityName
    }
}
