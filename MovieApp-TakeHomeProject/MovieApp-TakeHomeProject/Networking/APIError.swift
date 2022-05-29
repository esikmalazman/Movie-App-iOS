//
//  APIError.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 20/05/2022.
//

import Foundation

enum APIError : String, Error {
    case invalidURL = "The requested URL is invalid, please try again"
    case unableToComplete = "Unable to complete the request, please check your internet connection"
    case invalidData = "The data received from server is invalid, please try again "
    case invalidResponse = "Invalide response from server"
}
