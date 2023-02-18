//
//  HomeRouter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HomeRouter: HomeWireframeProtocol {
    
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func goingToProfile() {
        let vC = ProfileRouter.createModule()
        let nav = UINavigationController(rootViewController: vC)
        viewController?.present(nav, animated: true)
    }
    
    func goingToDetail(movieId: Int) {
        let vC = MovieDetailRouter.createModule(movieId: movieId)
        viewController?.navigationController?.pushViewController(vC, animated: true)
    }
    
    func goingToCloseSession() {
        var dbManager = DBManager()
        UserPreferences.saveRequestToken(requestToken: "")
        UserPreferences.saveSessionId(sessionId: "")
        dbManager.truncateTable()
        
        let vC = LoginRouter.createModule()
        viewController?.navigationController?.setViewControllers([vC], animated: true)
    }
}
