//
//  BMHomeViewController.swift
//  Media Editor
//
//  Created by Baptiste on 08/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol BMCustomizationDelegate: NSObjectProtocol {
    
    func customizationUpdate(_ choice: BMCustomization,
                             for type: BMCustomizationType)
}

extension BMHomeViewController: BMBottomViewDelegate {
   
    func customizationUpdate(_ customization: BMFilter,
                             for category: BMCustomizationCategory) {
        
        BMCustomizationManager.shared.allFilters[category] = customization
        
        let allFilters = BMCustomizationManager.shared.allFilters.map { $1 }
        
        guard let img = BMCustomizationManager.shared.initialImage
            else { return }
        
        BMCustomizationManager.shared.render(image: img, with: allFilters) { (image) in
            BMCustomizationManager.shared.filteredImage = image
            self.mediaRenderedImageView.image = image
        }
    }
    
    func dismissBottomView(animated: Bool = true) {
        showEditMenu(false, animated: animated)
    }
}

var isNewSticker: Bool = false

let kStickersDefaultSize: CGFloat = 60

class BMHomeViewController: UIViewController, UINavigationControllerDelegate {
        
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var shadeBackground: UIView!
    @IBOutlet weak var mediaBackView: UIView!
    @IBOutlet weak var mediaRenderedImageView: UIImageView!
    @IBOutlet weak var stickersWhiteBoardView: UIView!
    
    @IBOutlet weak var chooseMediaButton: UIButton!
    @IBOutlet weak var newMediaButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
        
    @IBOutlet weak var bottomViewBottomLayout: NSLayoutConstraint!
    
    @IBOutlet weak var mediaBackViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mediaBackViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mediaRenderedHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var bottomView: BMBottomView!

    static let identifier: String = "BMHomeViewController"

    var bottomViewIsHidden: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let w = chooseMediaButton.frame.size.width
        chooseMediaButton.layer.cornerRadius = w / 2
        chooseMediaButton.layer.masksToBounds = true
        
        newMediaButton.layer.cornerRadius = w / 2
        newMediaButton.layer.masksToBounds = true
        
        editButton.layer.cornerRadius = w / 2
        editButton.layer.masksToBounds = true
        editButton.isEnabled = false

        shareButton.layer.cornerRadius = w / 2
        shareButton.layer.masksToBounds = true
        shareButton.isEnabled = false

        bottomView.delegate = self
        
        let dropInteraction = UIDropInteraction(delegate: self)
        stickersWhiteBoardView.addInteraction(dropInteraction)
        stickersWhiteBoardView.isUserInteractionEnabled = true
        
        mediaRenderedHeightConstraint.constant = mediaRenderedImageView.frame.size.width * mediaRenderedImageView.image!.size.height / mediaRenderedImageView.image!.size.width
        
        view.layoutSubviews()
    }
    
    func mediaToEditHasUpdate() {
     
        guard let imageSize = BMCustomizationManager.shared.initialImage?.size,
            imageSize.width != 0
            else { return }

        let currentRatio = imageSize.height / imageSize.width
        mediaRenderedHeightConstraint.constant = mediaRenderedImageView.frame.size.width * currentRatio
        
        editButton.isEnabled = true
        shareButton.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if bottomViewIsHidden {
            showEditMenu(false, animated: false)
        }
    }
        
    func showEditMenu(_ show: Bool, animated: Bool = true) {
                    
        let buttonAlpha: CGFloat = show ? 0 : 1
        let constant: CGFloat = show ? 0 : -bottomView.frame.size.height - self.view.safeAreaInsets.bottom
        
        bottomViewBottomLayout.constant = constant

        UIView.animate(withDuration: animated ? 0.2 : 0,
                       animations: {

            self.newMediaButton.alpha = buttonAlpha
            self.chooseMediaButton.alpha = buttonAlpha
            self.editButton.alpha = buttonAlpha
            self.shareButton.alpha = buttonAlpha
            
            self.shadeBackground.alpha = show ? 0.8 : 0.2
            self.mediaBackView.backgroundColor = show ? .clear : .white
            
            self.view.layoutSubviews()
        })
        
        bottomViewIsHidden = !show
    }

    func openShareMenu(with image: UIImage) {
        
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        self.present(activityViewController, animated: true, completion: nil)
    }
}

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
