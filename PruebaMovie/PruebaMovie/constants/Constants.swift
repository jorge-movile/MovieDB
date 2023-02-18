//
//  Constants.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 15/02/23.
//

import Foundation

//Estructura en la cual se tienen los valores de algunos labels de los xibs
struct Constants {
    
    public static let placeholderUsername = "Username"
    public static let placeholderPassword = "Password"
    public static let msgLoginError = "Invalid username and/or password. You did not provide a valid login"
    public static let homeTitle = "Movies"
    public static let profileTitle = "Profile"
    public static let favoritesTitle = "Favorites Shows"
    
    struct Defaults {
        public static let REQUEST_DATA = "REQUEST_DATA"
        public static let SESSION_ID = "SESSION_ID"
    }
    
    struct LoadingConfig {
        static let size = CGSize(width: 70, height: 70)
    }
}
