//
//  LoginPresenter.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {
    
    weak private var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    private let router: LoginWireframeProtocol

    init(interface: LoginViewProtocol, interactor: LoginInteractorProtocol?, router: LoginWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func goToHome() {
        router.goingToHome()
    }
    
    func setLogin(request: LoginRequest) {
        interactor?.setLoginInt(request: request)
    }
    
    func createSession(request: SessionRequest) {
        interactor?.createSessionInt(request: request)
    }
    
    func loginSuccess(response: RequestTokenResponse) {
        view?.loginSuccessV(response: response)
    }
    
    func sessionSuccess(response: SessionIdResponse) {
        view?.sessionSuccessV(response: response)
    }
    
    func loginError() {
        view?.loginErrorV()
    }
    
    func showLoading() {
        view?.showLoading()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
}
