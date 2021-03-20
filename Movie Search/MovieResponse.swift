//
//  GenreResponse.swift
//  Movie Search
//
//  Created by Mohmed Master on 2021/03/09.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let results: [MovieResult]
}

// MARK: - Result
struct MovieResult: Codable {
    let id: Int
    let posterPath: String
    let title: String
    let voteAverage: Double

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
    }
}
