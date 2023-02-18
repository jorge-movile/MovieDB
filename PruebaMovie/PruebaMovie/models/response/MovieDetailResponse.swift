//
//  MovieDetailResponse.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 17/02/23.
//

import Foundation

struct MovieDetailResponse: Codable {
    let id: Int?
    let poster_path: String?
    let title: String?
    let overview: String?
    let vote_average: Float?
    let release_date: String?
    let production_companies: [ProductionCompanies]
}

struct ProductionCompanies: Codable {
    let id: Int?
    let logo_path: String?
}
