//
//  LoginProtocols.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: Presenter -> Router
protocol LoginWireframeProtocol: AnyObject {
    func goingToHome()
}

//MARK: View -> Presenter
protocol LoginPresenterProtocol: AnyObject {
    func goToHome()
    func setLogin(request: LoginRequest)
    func createSession(request: SessionRequest)
    func loginSuccess(response: RequestTokenResponse)
    func sessionSuccess(response: SessionIdResponse)
    func loginError()
    func showLoading()
    func hideLoading()
}

//MARK: Interactor -> Presenter
protocol LoginInteractorProtocol: AnyObject {
    var presenter: LoginPresenterProtocol?  { get set }
    func setLoginInt(request: LoginRequest)
    func createSessionInt(request: SessionRequest)
}

//MARK: Presenter -> View
protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol?  { get set }
    func loginSuccessV(response: RequestTokenResponse)
    func sessionSuccessV(response: SessionIdResponse)
    func loginErrorV()
    func showLoading()
    func hideLoading()
}
