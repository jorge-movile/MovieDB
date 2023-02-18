//
//  UserPreferences.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 16/02/23.
//

import Foundation
import UIKit

//Clase que sirve para guardar y recuperar UserDefaults
public class UserPreferences {
    
    public static func saveRequestToken(requestToken: String) {
        let defaults = UserDefaults.standard
        defaults.set(requestToken, forKey: Constants.Defaults.REQUEST_DATA)
    }
    
    public static func getRequestToken() -> String {
        let defaults = UserDefaults.standard
        let data = defaults.object(forKey: Constants.Defaults.REQUEST_DATA) as? String ?? ""
        
        return data
    }
    
    public static func saveSessionId(sessionId: String) {
        let defaults = UserDefaults.standard
        defaults.set(sessionId, forKey: Constants.Defaults.SESSION_ID)
    }
    
    public static func getSessionId() -> String {
        let defaults = UserDefaults.standard
        let data = defaults.object(forKey: Constants.Defaults.SESSION_ID) as? String ?? ""
        
        return data
    }
}
