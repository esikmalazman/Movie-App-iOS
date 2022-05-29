//
//  MovieList.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 15/05/2022.
//

import Foundation

struct MovieListResponse : Decodable {
    let page : Int
    let results : [Movie]?
}

struct Movie : Decodable {
    let original_language : String
    let original_title : String
    let vote_average : Float
    let poster_path : String?
    let id : Int
}

struct MovieDetails : Decodable {
    let backdrop_path : String?
    let poster_path : String?
    let title : String?
    let overview : String
    let runtime : Int
    let genres : [Genre]
    let spoken_languages : [Language]
}


