//
//  SplashViewController.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
	var presenter: SplashPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addBackgroundDegraded(startColor: Colors.greenOneDegraded, endColor: Colors.black)
        
        self.presenter?.getRequestToken()
    }
}

extension SplashViewController: SplashViewProtocol {
    
    func setRequestToken(response: RequestTokenResponse) {
        print("Response: \(response)")
        UserPreferences.saveRequestToken(requestToken: response.request_token)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if UserPreferences.getSessionId() == "" {
                self.presenter?.goToLogin()
            } else {
                self.presenter?.goToHome()
            }
        }
    }
}
