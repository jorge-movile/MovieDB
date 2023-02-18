//
//  MovieDetailProtocols.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: Presenter -> Router
protocol MovieDetailWireframeProtocol: AnyObject {
    func goingToBack()
}

//MARK: View -> Presenter
protocol MovieDetailPresenterProtocol: AnyObject {
    func goToBack()
    func getMovieDetail(movieId: Int)
    func showMessage(message: String)
    func showLoading()
    func hideLoading()
    func setMovieDetail(response: MovieDetailResponse)
}

//MARK: Interactor -> Presenter
protocol MovieDetailInteractorProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol?  { get set }
    func getMovieDetailInt(movieId: Int)
}

//MARK: Presenter -> View
protocol MovieDetailViewProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol?  { get set }
    func showMessage(message: String)
    func showLoading()
    func hideLoading()
    func setMovieDetail(response: MovieDetailResponse)
}
