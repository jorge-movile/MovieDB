//
//  SplashPresenter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SplashPresenter: SplashPresenterProtocol {
    
    weak private var view: SplashViewProtocol?
    var interactor: SplashInteractorProtocol?
    private let router: SplashWireframeProtocol

    init(interface: SplashViewProtocol, interactor: SplashInteractorProtocol?, router: SplashWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func goToLogin() {
        router.goingToLogin()
    }
    
    func getRequestToken() {
        interactor?.getRequestTokenInt()
    }
    
    func setRequestToken(response: RequestTokenResponse) {
        view?.setRequestToken(response: response)
    }
    
    func goToHome() {
        router.goingToHome()
    }
}
