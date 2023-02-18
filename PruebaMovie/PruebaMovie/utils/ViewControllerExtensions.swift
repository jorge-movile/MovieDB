//
//  ViewControllerExtensions.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 15/02/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Permite ocultar el teclado cuando se toque una View
    func hideKeyboardTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
