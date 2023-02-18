//
//  MovieDetailPresenter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    weak private var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    private let router: MovieDetailWireframeProtocol

    init(interface: MovieDetailViewProtocol, interactor: MovieDetailInteractorProtocol?, router: MovieDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func goToBack() {
        router.goingToBack()
    }
    
    func getMovieDetail(movieId: Int) {
        interactor?.getMovieDetailInt(movieId: movieId)
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
    
    func setMovieDetail(response: MovieDetailResponse) {
        view?.setMovieDetail(response: response)
    }
}
