//
//  MovieDetailInteractor.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 16/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    weak var presenter: MovieDetailPresenterProtocol?
    
    func getMovieDetailInt(movieId: Int) {
        presenter?.showLoading()
        
        var url = ConfigRequest.getUrlWs(typeAccess: "", endPoint: EndPoints.WS_GET_MOVIES_DETAIL)
        url = "\(url)/\(movieId)"
        let extraQueries = "&language=en-US"
        
        let request = ConfigRequest.getConfiguration(url: url, type: .get, data: nil, extraQueries: extraQueries)
            
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
                let response = try decoder.decode(MovieDetailResponse.self, from: data)
                self.presenter?.setMovieDetail(response: response)
            } catch {
                self.presenter?.showMessage(message: "Error: Trying to convert JSON to Model")
                return
            }
        }
        
        task.resume()
    }
}
