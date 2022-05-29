//
//  NetworkingManagerContract.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 20/05/2022.
//

import Foundation

protocol NetworkManagerContract {
    var apiKey : String { get }
    func fetchAPI<T:Decodable>(fromURL url : URL,forType type: T.Type,
                               completion : @escaping ((Result<T, APIError>)->Void))
}
