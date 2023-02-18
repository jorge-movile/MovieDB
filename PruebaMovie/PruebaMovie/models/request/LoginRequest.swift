//
//  LoginRequest.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 16/02/23.
//

import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String
    let request_token: String
}
