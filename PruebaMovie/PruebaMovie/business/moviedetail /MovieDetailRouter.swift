//
//  MovieDetailRouter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieDetailRouter: MovieDetailWireframeProtocol {
    
    weak var viewController: UIViewController?

    static func createModule(movieId: Int) -> UIViewController {
        
        let view = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interface: view, interactor: interactor, router: router)

        view.movieId = movieId
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func goingToBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
