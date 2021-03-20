//
//  GenreResponse.swift
//  Movie Search
//
//  Created by Mohmed Master on 2021/03/09.
//

import Foundation

// MARK: - GenreResponse
struct GenreResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
