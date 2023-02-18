//
//  CategoriesResponse.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 17/02/23.
//

import Foundation

struct CategoriesResponse: Codable {
    let genres: [Category]
}

struct Category: Codable {
    let id: Int
    let name: String
}
