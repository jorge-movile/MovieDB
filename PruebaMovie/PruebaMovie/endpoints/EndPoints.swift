//
//  EndPoints.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 16/02/23.
//

import Foundation

//Estructura donde se almacenan los Endpoint de los WS
struct EndPoints {
    
    static let PATH_IMAGES = "https://image.tmdb.org/t/p/w220_and_h330_face/"
    
    static let PATH_MAIN = "https://api.themoviedb.org/3/"
    
    static let TYPE_AUTHENTICATION = "authentication/"
    static let TYPE_GENRE = "genre/"
    
    static let WS_GET_TOKEN_NEW = "token/new"
    static let WS_GET_TOKEN_LOGIN = "token/validate_with_login"
    static let WS_SET_CREATE_SESSION = "session/new"
    static let WS_SET_ACCOUNT = "account"
    static let WS_GET_CATEGORIES_LIST = "movie/list"
    static let WS_GET_MOVIES_LIST = "list"
    static let WS_GET_MOVIES_DETAIL = "movie"
}
