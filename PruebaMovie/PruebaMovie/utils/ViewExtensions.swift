//
//  ViewExtensions.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 15/02/23.
//

import Foundation
import UIKit
import UIKit.UIView

extension UIView {
    
    //Crea un fondo degradado en el Splash y Login
    func addBackgroundDegraded(startColor: UIColor, endColor: UIColor) {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        gradient.opacity = 0.85
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
