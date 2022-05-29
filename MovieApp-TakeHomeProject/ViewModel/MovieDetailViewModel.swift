//
//  MovieDetailViewModel.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 18/05/2022.
//

import Foundation

protocol MovieDetailViewModelDelegate : AnyObject {
    func errorHandler(_ viewModel : MovieDetailViewModel, error: APIError)
}

class MovieDetailViewModel {
    
    let movieInteractor = MovieInteractor()
    var movideDetails : MovieDetails?
    weak var delegate : MovieDetailViewModelDelegate?
    
    
    func fetchMovideDetails(withId id : Int) {
        movieInteractor.fetchMovieDetails(fromMovieId: id) { result in
            switch result {
            case .success(let response):
                self.movideDetails = response
            case .failure(let error):
                self.delegate?.errorHandler(self, error: error)
            }
        }
    }
}

extension MovieDetailViewModel {
    func imageForMovie() -> String {
        let backdrop = movideDetails?.backdrop_path
        let poster = movideDetails?.poster_path
    
        var imageURL = ""
        
        if let backdrop = backdrop {
            imageURL = backdrop
        } else if let poster = poster {
            imageURL = poster
        }
        return imageURL
    }
    
    func durationForMovie() -> String? {
        if  let duration = movideDetails?.runtime {
            return "\(duration) min"
        }
        return nil
    }
    
    func synopsisForMovie() -> String {
        guard let sysnopsis = movideDetails?.overview else {
            return "No Synopsis Available"
        }
        
        return sysnopsis
    }
    
    func languageForMovie() -> String? {
        var languageList = [String]()
        guard let spokenLanguage = movideDetails?.spoken_languages, spokenLanguage.isEmpty == false else {
            return "No Language Available"
        }
        spokenLanguage.forEach({ language in
            languageList.append(language.name)
        })
        
        return languageList.joined(separator: ", ")
    }
    
    func genreForMovie() -> String? {
        var genreList = [String]()
        guard let genres = movideDetails?.genres, genres.isEmpty == false else {
           return "Genre Unspecified"
        }
        genres.forEach({ genre in
            genreList.append(genre.name)
        })
        return genreList.joined(separator: ", ")
    }
}

