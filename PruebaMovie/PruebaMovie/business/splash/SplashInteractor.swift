//
//  SplashInteractor.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SplashInteractor: SplashInteractorProtocol {

    weak var presenter: SplashPresenterProtocol?
    
    func getRequestTokenInt() {
        
        let url = ConfigRequest.getUrlWs(typeAccess: EndPoints.TYPE_AUTHENTICATION, endPoint: EndPoints.WS_GET_TOKEN_NEW)
        
        let request = ConfigRequest.getConfiguration(url: url, type: .get, data: nil)
            
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let decoder = JSONDecoder()
            
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                let response = try decoder.decode(RequestTokenResponse.self, from: data)
                self.presenter?.setRequestToken(response: response)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
        
        task.resume()
    }
}
