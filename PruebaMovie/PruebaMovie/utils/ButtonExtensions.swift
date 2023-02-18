//
//  ButtonExtensions.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 15/02/23.
//

import Foundation
import UIKit

extension UIButton {
    
    //Le asigna colores y estado a los botones
    func styleButton(isEnable: Bool, color: UIColor, textColor: UIColor) {
        
        self.backgroundColor = color
        self.setTitleColor(textColor, for: .normal)
        self.isEnabled = isEnable
        self.clipsToBounds = true
    }
}
