//
//  MovieListViewModel.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 17/05/2022.
//

import Foundation

enum SortByType : String {
    case release = "release_date.desc"
    case alphabet = "original_title.desc"
    case popularity = "popularity.desc"
}

protocol MovieListViewModelDelegate : AnyObject {
    func successHandler(_ viewModel : MovieListViewModel)
    func errorHandler(_ viewModel : MovieListViewModel, error: APIError)
}

class MovieListViewModel {
    
    let movieInteractor = MovieInteractor()
    
    weak var delegate : MovieListViewModelDelegate?
    
    var movies = [Movie]()
    var sortValue : SortByType = SortByType.release
    var moviePage = 1
    
    func fetchMovieLists() {
        movieInteractor.fetchMovieLists(sortBy: sortValue.rawValue, page: moviePage) { result in
            switch result {
                
            case .success(let response):
                let movies = response.results
                movies?.forEach { movie in
                    self.movies.append(movie)
                }
                self.delegate?.successHandler(self)
            case .failure(let error):
                self.delegate?.errorHandler(self, error: error)
            }
        }
    }
    
    func filterMovieBy(_ title : String) {
        if title == "Release date" {
            sortValue = .release
        } else if title == "A-Z" {
            sortValue = .alphabet
        } else {
            sortValue = .popularity
        }
        fetchMovieLists()
    }
}

extension MovieListViewModel {
    func removeAllMovies() {
        movies = []
    }
    
    func movieForCellAtIndex(_ index : Int) -> Movie {
        return movies[index]
    }
    
    func movieIdForCellAtIndex(_ index : Int) -> Int {
        return movies[index].id
    }
    
    func moviePosterUrl(atIndex index: Int) ->  String? {
        if let url = movies[index].poster_path {
            return url
        }
        return nil
    }
    
    func resetMoviePage() {
        moviePage = 1
    }
    
    func nextMoviePage() {
        moviePage = moviePage + 1
        fetchMovieLists()
    }
}
