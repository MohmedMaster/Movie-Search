//
//  MovieRequest.swift
//  Movie Search
//
//  Created by Mohmed Master on 2021/03/03.
//

import Foundation

struct MovieRequest{
    
    let baseURL = "https://api.themoviedb.org/3"
    let API_KEY = "ee036f9f822894353f9777758b2a1de4"
    
    //movies = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(API_KEY)&language=en-US&page=1"
    //genre = https://api.themoviedb.org/3/movie/{movie_id}?api_key=<<api_key>>&language=en-US
        
    
    func getMoviesInCinemas(completion: @escaping(Result<[MovieResult], Error>)-> Void){
        
        
        guard let movieURL = URL(string: "\(baseURL)/movie/now_playing?api_key=\(API_KEY)&language=en-US&page=1") else {
            fatalError()
        }
        
        let dataTask = URLSession.shared.dataTask(with: movieURL) { data, _, _ in
            guard let jsonData = data else {
                fatalError()
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: jsonData)
                let result = response.results
                completion(.success(result))
                
            } catch {
                fatalError()
            }
        }
        dataTask.resume()
    }
    
    func getMovieGenre(id: Int, indexPath: IndexPath ,completion: @escaping((Result<[Genre], Error>), IndexPath) -> Void){
        
        //Genre URL
        guard let genreURL = URL(string: "\(baseURL)/movie/\(id)?api_key=\(API_KEY)&language=en-US") else {
            fatalError()
        }
        
        let dataTask = URLSession.shared.dataTask(with: genreURL) { data, _, _ in
            guard let jsonData = data else {
                fatalError()
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GenreResponse.self, from: jsonData)
                let result = response.genres
                completion(.success(result), indexPath)

            } catch {
                fatalError()
            }
        }
        dataTask.resume()
    }
    
}
