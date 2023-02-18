//
//  LoginViewController.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoginViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageDecorative: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lbMessageError: UILabel!
    
    var presenter: LoginPresenterProtocol?
    var validations = (userName: false, password: false)
    var userName = ""
    var password = ""

	override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setUpView() {
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.hideKeyboardTappedAround()
        
        viewContainer.addBackgroundDegraded(startColor: Colors.greenOneDegraded, endColor: Colors.black)
        
        imageDecorative.backgroundColor = UIColor.clear
        imageDecorative.isOpaque = false
        
        txtUsername.placeholder = Constants.placeholderUsername
        txtUsername.autocorrectionType = .no
        txtUsername.delegate = self
        
        txtPassword.placeholder = Constants.placeholderPassword
        txtPassword.autocorrectionType = .no
        txtPassword.delegate = self
        
        lbMessageError.text = Constants.msgLoginError
        
        btnLogin.styleButton(isEnable: false, color: Colors.gray, textColor: Colors.white)
    }
    
    func validationsComplete() {
        if validations.userName, validations.password {
            btnLogin.styleButton(isEnable: true, color: Colors.green, textColor: Colors.white)
        } else {
            btnLogin.styleButton(isEnable: false, color: Colors.gray, textColor: Colors.white)
        }
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        let request = LoginRequest(username: userName, password: password, request_token: UserPreferences.getRequestToken())
        presenter?.setLogin(request: request)
    }
}

extension LoginViewController: LoginViewProtocol {
    
    func loginSuccessV(response: RequestTokenResponse) {
        
    }
    
    func sessionSuccessV(response: SessionIdResponse) {
        print("Login success")
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UserPreferences.saveSessionId(sessionId: response.session_id)
            self.presenter?.goToHome()
            self.btnLogin.styleButton(isEnable: false, color: Colors.gray, textColor: Colors.white)
        }
    }
    
    func loginErrorV() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.lbMessageError.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.lbMessageError.isHidden = true
            }
        }
    }
    
    func showLoading() {
        self.startAnimating(Constants.LoadingConfig.size, type: NVActivityIndicatorType.lineSpinFadeLoader, color: Colors.greenItemMovies)
    }
    
    func hideLoading() {
        self.stopAnimating()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
        if textField == self.txtUsername {
            self.txtPassword.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
            return true
        }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.txtUsername {
            if textField.text?.count == 0 || textField.text == " " {
                self.validations.userName = false
            } else {
                self.validations.userName = true
                if let userNameSuccess = textField.text {
                    self.userName = userNameSuccess
                }
            }
        } else {
            if textField.text?.count == 0 || textField.text == " " {
                self.validations.password = false
            } else {
                self.validations.password = true
                if let passwordSuccess = textField.text {
                    self.password = passwordSuccess
                }
            }
            
            textField.resignFirstResponder()
        }
        
        validationsComplete()
    }
}
