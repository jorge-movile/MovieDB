//
//  ImageViewExtensions.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 17/02/23.
//

import Foundation

import UIKit
import Nuke

extension UIImageView {
    
    //coloca la imagen obtenida en los WS y la pone en el UIImageView correspondiente
    func setImageFromUrl(urlPhoto: String) {
        let url = URL(string: "\(EndPoints.PATH_IMAGES)\(urlPhoto)")
        
        let options = ImageLoadingOptions(
            //placeholder: UIImage(named: "logo"),
            failureImage: UIImage(named: "not_image"),
            contentModes: .init(success: .scaleAspectFill, failure: .center, placeholder: .center)
        )
        
        var request = ImageRequest(url: url!)
        request.memoryCacheOptions.isWriteAllowed = true
        request.memoryCacheOptions.isReadAllowed = true
        request.priority = .high
        Nuke.loadImage(with: request, options: options, into: self)
    }
}
