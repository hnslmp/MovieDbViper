//
//  ApiManager.swift
//  MovieDbViper
//
//  Created by Hansel Matthew on 21/10/22.
//

import Foundation
import Network

class ApiManager {
    static let shared = ApiManager()
    
    func getMoviesGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(Constants.apiKey)&language=en-US") else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(GenresResponse.self, from: data)
                completion(.success(results.genres))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getMoviesList(genre: String, completion: @escaping (Result<[MovieResult], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(Constants.apiKey)&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=Animation&with_watch_monetization_types=flatrate") else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(MovieListResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
