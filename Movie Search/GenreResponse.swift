//
//  GenreResponse.swift
//  Movie Search
//
//  Created by Mohmed Master on 2021/03/09.
//

import Foundation

// MARK: - GenreResponse
struct GenreResponse: Codable {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollection??
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

struct BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

/*// This file was generated from JSON Schema using quicktype, do not modify it directly.
 // To parse the JSON, add this file to your project and do:
 //
 //   let genreResponse = try? newJSONDecoder().decode(GenreResponse.self, from: jsonData)

 import Foundation

 // MARK: - GenreResponse
 struct GenreResponse: Codable {
     let adult: Bool
     let backdropPath: String
     let belongsToCollection: BelongsToCollection
     let budget: Int
     let genres: [Genre]
     let homepage: String
     let id: Int
     let imdbID, originalLanguage, originalTitle, overview: String
     let popularity: Double
     let posterPath: String
     let productionCompanies: [ProductionCompany]
     let productionCountries: [ProductionCountry]
     let releaseDate: String
     let revenue, runtime: Int
     let spokenLanguages: [SpokenLanguage]
     let status, tagline, title: String
     let video: Bool
     let voteAverage: Double
     let voteCount: Int

     enum CodingKeys: String, CodingKey {
         case adult
         case backdropPath = "backdrop_path"
         case belongsToCollection = "belongs_to_collection"
         case budget, genres, homepage, id
         case imdbID = "imdb_id"
         case originalLanguage = "original_language"
         case originalTitle = "original_title"
         case overview, popularity
         case posterPath = "poster_path"
         case productionCompanies = "production_companies"
         case productionCountries = "production_countries"
         case releaseDate = "release_date"
         case revenue, runtime
         case spokenLanguages = "spoken_languages"
         case status, tagline, title, video
         case voteAverage = "vote_average"
         case voteCount = "vote_count"
     }
 }

 // MARK: - BelongsToCollection
 struct BelongsToCollection: Codable {
     let id: Int
     let name, posterPath, backdropPath: String

     enum CodingKeys: String, CodingKey {
         case id, name
         case posterPath = "poster_path"
         case backdropPath = "backdrop_path"
     }
 }

 // MARK: - Genre
 struct Genre: Codable {
     let id: Int
     let name: String
 }

 // MARK: - ProductionCompany
 struct ProductionCompany: Codable {
     let id: Int
     let logoPath: String?
     let name, originCountry: String

     enum CodingKeys: String, CodingKey {
         case id
         case logoPath = "logo_path"
         case name
         case originCountry = "origin_country"
     }
 }

 // MARK: - ProductionCountry
 struct ProductionCountry: Codable {
     let iso3166_1, name: String

     enum CodingKeys: String, CodingKey {
         case iso3166_1 = "iso_3166_1"
         case name
     }
 }

 // MARK: - SpokenLanguage
 struct SpokenLanguage: Codable {
     let englishName, iso639_1, name: String

     enum CodingKeys: String, CodingKey {
         case englishName = "english_name"
         case iso639_1 = "iso_639_1"
         case name
     }
 }
*/
