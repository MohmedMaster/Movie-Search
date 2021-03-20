//
//  MovieRequest.swift
//  Movie Search
//
//  Created by Mohmed Master on 2021/03/03.
//

import Foundation

struct MovieRequest {

    func fetchMoviesInCinemas(completion: @escaping(Result<[MovieResult], Error>) -> Void) {
        // Movie URL
        let allMoviesInCinemasURL = "\(MovieConstants.baseURL)/movie/now_playing?api_key=\(MovieConstants.apiKEY)&language=en-US&page=1"

        guard let movieURL = URL(string: allMoviesInCinemasURL) else {
            fatalError()
        }

        let dataTask = URLSession.shared.dataTask(with: movieURL) { data, _, _ in
            guard let jsonData = data else {
                fatalError("Failed to get data from url")
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(MovieResponse.self, from: jsonData)
                let result = response.results
                completion(.success(result))

            } catch {
                fatalError("Failed to decode")
            }
        }
        dataTask.resume()
    }

    func fetchGenreDetail(movieId: Int, indexPath: IndexPath, completion: @escaping((Result<[Genre],
                                                                                         Error>), IndexPath) -> Void) {
        // Genre URL
        let movieDetailURL = "\(MovieConstants.baseURL)/movie/\(movieId)?api_key=\(MovieConstants.apiKEY)&language=en-US"

        guard let genreURL = URL(string: movieDetailURL) else {
            fatalError()
        }

        let dataTask = URLSession.shared.dataTask(with: genreURL) { data, _, _ in
            guard let jsonData = data else {
                fatalError("Failed to get data from url")
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(GenreResponse.self, from: jsonData)
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = response.genres
                completion(.success(result), indexPath)

            } catch {
                fatalError("Failed to decode")
            }
        }
        dataTask.resume()
    }
}
