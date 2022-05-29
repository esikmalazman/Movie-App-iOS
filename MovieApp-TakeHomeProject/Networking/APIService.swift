//
//  APIService.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 17/05/2022.
//

import Foundation

enum Endpoint : String {
    case movieList = "discover/movie/"
    case movie = "movie/"
}

enum ApiURL : String {
    case baseURL = "https://api.themoviedb.org/3/"
    case imageBaseURL = "https://image.tmdb.org/t/p/w500"
    case bookMovieURL = "https://www.cathaycineplexes.com.sg"
}
