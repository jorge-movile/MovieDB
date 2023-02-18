//
//  MoviesResponse.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 17/02/23.
//

import Foundation

struct MoviesResponse: Codable {
    let items: [Movie]
}

struct Movie: Codable {
    let id: Int?
    let poster_path: String?
    let title: String?
    let overview: String?
    let vote_average: Float?
    let release_date: String?
    var isFavorite: Bool?
}
