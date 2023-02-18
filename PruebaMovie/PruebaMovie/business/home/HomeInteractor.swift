//
//  HomeInteractor.swift
//  PruebaMovie
//
//  Created Jorge Espinoza on 15/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HomeInteractor: HomeInteractorProtocol {
    
    weak var presenter: HomePresenterProtocol?
    
    func getCategoriesListInt() {
        
        presenter?.showLoading()
        
        let url = ConfigRequest.getUrlWs(typeAccess: EndPoints.TYPE_GENRE, endPoint: EndPoints.WS_GET_CATEGORIES_LIST)
        let extraQueries = "&language=en-US"
        
        let request = ConfigRequest.getConfiguration(url: url, type: .get, data: nil, extraQueries: extraQueries)
            
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let decoder = JSONDecoder()
            self.presenter?.hideLoading()
            
            guard error == nil else {
                self.presenter?.showMessage(message: "Error: error calling POST")
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
                let response = try decoder.decode(CategoriesResponse.self, from: data)
                self.presenter?.setCategoriesList(categoriesList: response.genres)
            } catch {
                self.presenter?.showMessage(message: "Error: Trying to convert JSON to Model")
                return
            }
        }
        
        task.resume()
    }
    
    func getMoviesListInt(categoryId: Int) {
        presenter?.showLoading()
        
        var url = ConfigRequest.getUrlWs(typeAccess: "", endPoint: EndPoints.WS_GET_MOVIES_LIST)
        url = "\(url)/\(categoryId)"
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
                let response = try decoder.decode(MoviesResponse.self, from: data)
                self.presenter?.setMoviesList(moviesList: response.items)
            } catch {
                self.presenter?.showMessage(message: "Error: Trying to convert JSON to Model")
                return
            }
        }
        
        task.resume()
    }
}
