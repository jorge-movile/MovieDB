//
//  RequestTokenResponse.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 16/02/23.
//

import Foundation

struct RequestTokenResponse: Codable {
    let success: Bool
    let expires_at: String
    let request_token: String
}
