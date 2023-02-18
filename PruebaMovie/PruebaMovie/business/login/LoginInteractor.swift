//
//  LoginInteractor.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginInteractor: LoginInteractorProtocol {
    
    weak var presenter: LoginPresenterProtocol?
    
    func setLoginInt(request: LoginRequest) {
        
        presenter?.showLoading()
        
        let url = ConfigRequest.getUrlWs(typeAccess: EndPoints.TYPE_AUTHENTICATION, endPoint: EndPoints.WS_GET_TOKEN_LOGIN)
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(request) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        let request = ConfigRequest.getConfiguration(url: url, type: .post, data: jsonData)
            
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let decoder = JSONDecoder()
            
            guard error == nil else {
                print("Error: error calling POST")
                self.presenter?.hideLoading()
                self.presenter?.loginError()
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                self.presenter?.hideLoading()
                self.presenter?.loginError()
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                self.presenter?.hideLoading()
                self.presenter?.loginError()
                return
            }
            do {
                let response = try decoder.decode(RequestTokenResponse.self, from: data)
                
                if response.success {
                    UserPreferences.saveRequestToken(requestToken: response.request_token)
                    self.presenter?.createSession(request: SessionRequest(request_token: response.request_token))
                } else {
                    self.presenter?.loginError()
                }
            } catch {
                self.presenter?.hideLoading()
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
        
        task.resume()
    }
    
    func createSessionInt(request: SessionRequest) {
        
        let url = ConfigRequest.getUrlWs(typeAccess: EndPoints.TYPE_AUTHENTICATION, endPoint: EndPoints.WS_SET_CREATE_SESSION)
        
        guard let jsonData = try? JSONEncoder().encode(request) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        let request = ConfigRequest.getConfiguration(url: url, type: .post, data: jsonData)
            
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let decoder = JSONDecoder()
            self.presenter?.hideLoading()
            
            guard error == nil else {
                print("Error: error calling POST")
                self.presenter?.loginError()
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                self.presenter?.loginError()
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                self.presenter?.loginError()
                return
            }
            do {
                let response = try decoder.decode(SessionIdResponse.self, from: data)
                
                if response.success {
                    self.presenter?.sessionSuccess(response: response)
                } else {
                    self.presenter?.loginError()
                }
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
        
        task.resume()
    }
}
