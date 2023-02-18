//
//  SplashRouter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SplashRouter: SplashWireframeProtocol {
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        
        let view = SplashViewController(nibName: "SplashViewController", bundle: nil)
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func goingToLogin() {
        let vC = LoginRouter.createModule()
        viewController?.navigationController?.setViewControllers([vC], animated: true)
    }
    
    func goingToHome() {
        let vC = HomeRouter.createModule()
        viewController?.navigationController?.setViewControllers([vC], animated: true)
    }
}
