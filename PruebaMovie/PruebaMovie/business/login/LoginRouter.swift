//
//  LoginRouter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginRouter: LoginWireframeProtocol {
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        
        let view = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let presenter = LoginPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func goingToHome() {
        let vC = HomeRouter.createModule()
        viewController?.navigationController?.setViewControllers([vC], animated: true)
    }
}
