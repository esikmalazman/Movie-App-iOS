//
//  MovieInteractorContract.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 20/05/2022.
//

import Foundation

protocol MovieInteractorContract {
    func fetchMovieLists(
        sortBy: String,
        page : Int,
        completion : @escaping ((Result<MovieListResponse, APIError>)->Void))
    
    func fetchMovieDetails(
        fromMovieId id : Int,
        completion : @escaping ((Result<MovieDetails, APIError>)->Void))
}
