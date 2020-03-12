//
//  BMHomeViewController+UserActions.swift
//  Media Editor
//
//  Created by Baptiste on 11/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit

extension BMHomeViewController {
    
    @IBAction func chooseMediaFromLibraryAction() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            showPicker(sourceType: .photoLibrary)
        }        
    }
    
    @IBAction func newMediaAction() {
        showPicker(sourceType: .camera)
    }
    
    func showPicker(sourceType: UIImagePickerController.SourceType) {
        
       let pickerController = UIImagePickerController()
       pickerController.delegate = self
       pickerController.allowsEditing = false
       pickerController.mediaTypes = ["public.image", "public.movie"]
       pickerController.sourceType = sourceType
    
       present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func editMediaAction() {
        showEditMenu(true, animated: true)
    }
    
    func generateFinalImage(_ completion: @escaping (UIImage?) -> Void) {
        
        guard let filteredImage = BMCustomizationManager.shared.filteredImage ?? BMCustomizationManager.shared.initialImage
            else { return }

        // if no stickers added
        if stickersWhiteBoardView.subviews.count == 0 {
            completion(filteredImage)
            return
        }

        let stickersLayer = stickersWhiteBoardView.asImage(outputSize: filteredImage.size)
        
        let customization = BMStickerFilter(choices: [BMStickerCustomization(stickersLayer)])
        
        BMCustomizationManager.shared.render(image: filteredImage, with: [customization]) { (image) in
            completion(image)
        }
    }
    
    @IBAction func shareAction() {
        
        generateFinalImage { (image) in
            if let image = image {
                self.openShareMenu(with: image)
            }
        }
    }
}
