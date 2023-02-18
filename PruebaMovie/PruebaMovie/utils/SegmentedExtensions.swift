//
//  SegmentedExtensions.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 15/02/23.
//

import Foundation
import UIKit

extension UISegmentedControl {
    
    func styleSegmented(backgroundColor: UIColor, selectedColor: UIColor, textcolor: UIColor) {
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.white]
        self.setTitleTextAttributes(titleTextAttributes, for: .normal)
        self.setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        self.selectedSegmentTintColor = Colors.graySegmented
        self.backgroundColor = Colors.semiBlack
        //self.clipsToBounds = true
    }
}
