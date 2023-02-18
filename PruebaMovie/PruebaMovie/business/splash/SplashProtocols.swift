//
//  SplashProtocols.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: Presenter -> Router
protocol SplashWireframeProtocol: AnyObject {
    func goingToLogin()
    func goingToHome()
}

//MARK: View -> Presenter
protocol SplashPresenterProtocol: AnyObject {
    func goToLogin()
    func getRequestToken()
    func setRequestToken(response: RequestTokenResponse)
    func goToHome()
}

//MARK: Interactor -> Presenter
protocol SplashInteractorProtocol: AnyObject {
    var presenter: SplashPresenterProtocol?  { get set }
    func getRequestTokenInt()
}

//MARK: Presenter -> View
protocol SplashViewProtocol: AnyObject {
    var presenter: SplashPresenterProtocol?  { get set }
    func setRequestToken(response: RequestTokenResponse)
}
