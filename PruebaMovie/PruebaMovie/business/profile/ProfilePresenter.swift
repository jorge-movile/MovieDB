//
//  ProfilePresenter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak private var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    private let router: ProfileWireframeProtocol

    init(interface: ProfileViewProtocol, interactor: ProfileInteractorProtocol?, router: ProfileWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
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
    
    func getAccount() {
        interactor?.getAccountInt()
    }
    
    func setAccount(response: AccountResponse) {
        view?.setAccount(response: response)
    }
    
    func getFavoriteList() -> [FavoritesTable] {
        let dbManager = DBManager()
        return dbManager.getFavoritesList(isFavorite: true)
    }
}
