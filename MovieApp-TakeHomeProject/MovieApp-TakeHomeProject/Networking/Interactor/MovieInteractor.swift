//
//  MovieInteractor.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 17/05/2022.
//

import Foundation

class MovieInteractor {
    let networkManager = NetworkManager()
}

extension MovieInteractor : MovieInteractorContract {
    func fetchMovieLists(sortBy: String, page : Int, completion : @escaping ((Result<MovieListResponse, APIError>)->Void)) {
        
        let urlString =  ApiURL.baseURL.rawValue + Endpoint.movieList.rawValue + networkManager.apiKey + "&sort_by=\(sortBy)" + "&page=\(page)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkManager.fetchAPI(fromURL: url, forType: MovieListResponse.self) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetails(fromMovieId id : Int, completion : @escaping ((Result<MovieDetails, APIError>)->Void)) {
        
        let urlString = ApiURL.baseURL.rawValue + Endpoint.movie.rawValue + "\(id)" + networkManager.apiKey
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkManager.fetchAPI(fromURL: url, forType: MovieDetails.self) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
