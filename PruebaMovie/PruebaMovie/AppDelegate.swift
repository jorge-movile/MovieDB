//
//  AppDelegate.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 15/02/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configApp()
        
        return true
    }

    func configApp() {
        window = UIWindow()
        
        let splashViewController = UINavigationController(rootViewController: SplashRouter.createModule())
        
        /*let homeViewController = UINavigationController(rootViewController: SplashRouter.createModule())*/
        
        window?.rootViewController = splashViewController
        window?.makeKeyAndVisible()
    }
}
