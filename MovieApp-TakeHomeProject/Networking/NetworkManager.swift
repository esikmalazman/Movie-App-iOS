//
//  NetworkManager.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 17/05/2022.


import Foundation

class NetworkManager : NetworkManagerContract {
    var apiKey : String {
        return "?api_key=328c283cd27bd1877d9080ccb1604c91"
    }
    
    func fetchAPI<T:Decodable>(fromURL url : URL,forType type: T.Type,
                               completion : @escaping ((Result<T, APIError>) -> Void)) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let objectToDecode = try JSONDecoder().decode(T.self, from: data)
                completion(.success(objectToDecode))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}


