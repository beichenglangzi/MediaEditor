//
//  BMHomeViewController+ImagePicker.swift
//  Media Editor
//
//  Created by Baptiste on 12/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

extension BMHomeViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[. originalImage] as? UIImage,
            let simplifiedImage = image.fixedOrientation() {
            
            BMCustomizationManager.shared.initialImage = simplifiedImage
            self.mediaRenderedImageView.image = simplifiedImage
            self.stickersWhiteBoardView.subviews.forEach({ $0.removeFromSuperview() })
            self.mediaToEditHasUpdate()
        }
    }
}
