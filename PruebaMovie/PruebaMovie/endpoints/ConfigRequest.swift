//
//  ConfigRequest.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 16/02/23.
//

import Foundation

//Clase que se encarga de armar el request para consumir los WS
class ConfigRequest {
    
    public static func getConfiguration(url: String, type: TypeRequest, data: Data?, extraQueries: String = "", isAccount: Bool = false) -> URLRequest {
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "KEY_API_MDB") as? String ?? ""
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "ACCESS_TOKEN") as? String ?? ""
        
        var finalUrl = "\(url)?api_key=\(apiKey)\(extraQueries)"
        
        if isAccount {
            finalUrl = "\(url)?api_key=\(apiKey)\(extraQueries)&session_id=\(UserPreferences.getSessionId())"
        }
        
        print("WS Url: \(finalUrl)")
        
        let urlWS = URL(string: finalUrl)
        
        // Create the url request
        var request = URLRequest(url: urlWS!)
        
        request.httpMethod = type.rawValue
        
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the response expected to be in JSON format
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        if type == .post {
            request.httpBody = data
        }
        
        return request
    }
    
    public static func getUrlWs(typeAccess: String, endPoint: String) -> String {
        return "\(NetworkConfig.dominio)\(typeAccess)\(endPoint)"
    }
}

//Estructura con los predicados de las operacions http
enum TypeRequest: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}
