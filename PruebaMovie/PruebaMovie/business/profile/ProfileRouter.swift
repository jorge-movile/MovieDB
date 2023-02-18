//
//  ProfileRouter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ProfileRouter: ProfileWireframeProtocol {
    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        let presenter = ProfilePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
