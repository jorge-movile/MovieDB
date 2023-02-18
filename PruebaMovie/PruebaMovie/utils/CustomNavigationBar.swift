//
//  CustomNavigationBar.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 15/02/23.
//

import Foundation
import UIKit

struct CustomBarButton {
    var icon: UIImage?
    var title: String?
    var selector: Selector?
    
    init(icon: UIImage?, title: String?, selector: Selector?) {
        self.icon = icon
        self.title = title
        self.selector = selector
    }
}

//Clase que permite crear el NavigationBar y sus items
class CustomNavigationBar {
    
    public static func createNavigationBar(reference vc: UIViewController, backgroundColor: UIColor, textColor: UIColor, title: String, leftButtonItem: CustomBarButton? , rigthButtonItem: CustomBarButton?) {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.shadowColor = .clear
        let attributes = [NSAttributedString.Key.foregroundColor: textColor]
        appearance.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        vc.navigationController?.navigationBar.tintColor = backgroundColor
        vc.navigationController?.navigationBar.standardAppearance = appearance
        vc.navigationController?.navigationBar.compactAppearance = appearance
        vc.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        vc.navigationController?.navigationBar.barTintColor = .white
        vc.title = title
        
        addBarButton(leftButtonItem: leftButtonItem, rigthButtonItem: rigthButtonItem, vc: vc)
    }
    
    private static func addBarButton(leftButtonItem: CustomBarButton? , rigthButtonItem: CustomBarButton?, vc: UIViewController) {
        
        if let buttonL = leftButtonItem {
            let leftBarButton = UIBarButtonItem()
            leftBarButton.image = leftButtonItem?.icon
            leftBarButton.title = leftButtonItem?.title
            leftBarButton.action = leftButtonItem?.selector
            leftBarButton.target = vc
            leftBarButton.tintColor = .white
            vc.navigationItem.leftBarButtonItem = leftBarButton
        }
        
        if let buttonR = rigthButtonItem {
            let rigthButton = UIBarButtonItem()
            rigthButton.image = rigthButtonItem?.icon
            rigthButton.title = rigthButtonItem?.title
            rigthButton.action = rigthButtonItem?.selector
            rigthButton.target = vc
            rigthButton.tintColor = .white
            vc.navigationItem.rightBarButtonItem = rigthButton
        }
    }
}
