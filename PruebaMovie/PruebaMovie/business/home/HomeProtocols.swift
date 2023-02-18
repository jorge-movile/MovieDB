//
//  HomeProtocols.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

//MARK: Presenter -> Router
protocol HomeWireframeProtocol: AnyObject {
    func goingToProfile()
    func goingToDetail(movieId: Int)
    func goingToCloseSession()
}

//MARK: View -> Presenter
protocol HomePresenterProtocol: AnyObject {
    func showOptionMenu(vc: UIViewController)
    func goToProfile()
    func goToDetail(movieId: Int)
    func getCategoriesList()
    func showMessage(message: String)
    func showLoading()
    func hideLoading()
    func setCategoriesList(categoriesList: [Category])
    func getMoviesList(categoryId: Int)
    func setMoviesList(moviesList: [Movie])
    func goToCloseSession()
}

//MARK: Interactor -> Presenter
protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterProtocol?  { get set }
    func getCategoriesListInt()
    func getMoviesListInt(categoryId: Int)
}

//MARK: Presenter -> View
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol?  { get set }
    func showMessage(message: String)
    func showLoading()
    func hideLoading()
    func setCategoriesList(categoriesList: [Category])
    func setMoviesList(moviesList: [Movie])
}
