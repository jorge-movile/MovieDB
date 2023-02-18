//
//  HomePresenter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HomePresenter: HomePresenterProtocol {
    
    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    private let router: HomeWireframeProtocol

    init(interface: HomeViewProtocol, interactor: HomeInteractorProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func showOptionMenu(vc: UIViewController) {
        
        var actions: [(String, UIAlertAction.Style)] = []
        actions.append(("View Profile", UIAlertAction.Style.default))
        actions.append(("Log out", UIAlertAction.Style.destructive))
        actions.append(("Cancel", UIAlertAction.Style.cancel))
        
        let alertViewController = UIAlertController(title: "What do you want to do?", message: "", preferredStyle: .actionSheet)
        
        for (index, (title, style)) in actions.enumerated() {
            let alertAction = UIAlertAction(title: title, style: style) { _ in
                switch (index) {
                case 0:
                    print("Profile")
                    self.goToProfile()
                case 1:
                    self.goToCloseSession()
                case 2:
                    print("Cancel")
                default:
                    print("Default")
                }
            }
            alertViewController.addAction(alertAction)
        }
        // iPad Support
        alertViewController.popoverPresentationController?.sourceView = vc.view.self
        vc.present(alertViewController, animated: true, completion: nil)
    }
    
    func goToProfile() {
        router.goingToProfile()
    }
    
    func goToDetail(movieId: Int) {
        router.goingToDetail(movieId: movieId)
    }
    
    func getCategoriesList() {
        interactor?.getCategoriesListInt()
    }
    
    func setCategoriesList(categoriesList: [Category]) {
        view?.setCategoriesList(categoriesList: categoriesList)
    }
    
    func getMoviesList(categoryId: Int) {
        interactor?.getMoviesListInt(categoryId: categoryId)
    }
    
    func setMoviesList(moviesList: [Movie]) {
        view?.setMoviesList(moviesList: moviesList)
    }
    
    func showMessage(message: String) {
        view?.showMessage(message: message)
    }
    
    func showLoading() {
        view?.showLoading()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
    
    func goToCloseSession() {
        router.goingToCloseSession()
    }
}
