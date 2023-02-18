//
//  ProfileInteractor.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ProfileInteractor: ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterProtocol?
    
    func getAccountInt() {
        presenter?.showLoading()
        
        let url = ConfigRequest.getUrlWs(typeAccess: "", endPoint: EndPoints.WS_SET_ACCOUNT)
        let request = ConfigRequest.getConfiguration(url: url, type: .get, data: nil, isAccount: true)
            
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let decoder = JSONDecoder()
            self.presenter?.hideLoading()
            
            guard error == nil else {
                self.presenter?.showMessage(message: "Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                self.presenter?.showMessage(message: "Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                self.presenter?.showMessage(message: "Error: HTTP request failed")
                return
            }
            do {
                let response = try decoder.decode(AccountResponse.self, from: data)
                self.presenter?.setAccount(response: response)
            } catch {
                self.presenter?.showMessage(message: "Error: Trying to convert JSON to Model")
                return
            }
        }
        
        task.resume()
    }
}
