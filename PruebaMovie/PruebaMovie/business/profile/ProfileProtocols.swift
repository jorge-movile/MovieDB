//
//  ProfileProtocols.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: Presenter -> Router
protocol ProfileWireframeProtocol: AnyObject {
    
}

//MARK: View -> Presenter
protocol ProfilePresenterProtocol: AnyObject {
    func showLoading()
    func showMessage(message: String)
    func hideLoading()
    func getAccount()
    func setAccount(response: AccountResponse)
    func getFavoriteList() -> [FavoritesTable]
}

//MARK: Interactor -> Presenter
protocol ProfileInteractorProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol?  { get set }
    func getAccountInt()
}

//MARK: Presenter -> View
protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol?  { get set }
    func showMessage(message: String)
    func showLoading()
    func hideLoading()
    func setAccount(response: AccountResponse)
}
