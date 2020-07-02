//
//  WebServiceHandler.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine
import SPDNetwork

final class WebServiceHandler {
    func fetchTrendingMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, SPDNetworkError> {
        let url = try SPDNetworkURLBuilder()
            .set(operation: .trending(timeWindow: .day))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try SPDNetworking<MoviesResponse>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
    
    func fetchPopularMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, SPDNetworkError> {
        let url = try SPDNetworkURLBuilder()
            .set(operation: .popular)
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try SPDNetworking<MoviesResponse>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
    
    func fetchNowPlayingMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, SPDNetworkError> {
        let url = try SPDNetworkURLBuilder()
            .set(operation: .nowPlaying)
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try SPDNetworking<MoviesResponse>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
    
    func fetchUpcomingMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, SPDNetworkError> {
        
        let url = try SPDNetworkURLBuilder()
            .set(operation: .upcoming)
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try SPDNetworking<MoviesResponse>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
    
    func fetchTopRatedMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, SPDNetworkError> {
        let url = try SPDNetworkURLBuilder()
            .set(operation: .topRated)
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try SPDNetworking<MoviesResponse>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
    
    func fetchDetails(movie id: Int) throws -> AnyPublisher<MovieDetailsResponseModel, SPDNetworkError> {
        let url = try SPDNetworkURLBuilder()
            .set(operation: .details(media: .movie, movieId: "\(id)"))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .build()
        
        return try SPDNetworking<MovieDetailsResponseModel>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
    
    func fetchCredits(movie id: Int) throws -> AnyPublisher<MovieCreditsResponseModel, SPDNetworkError> {
        let url = try SPDNetworkURLBuilder()
            .set(operation: .credits(media: .movie, movieId: "\(id)"))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .build()
        
        return try SPDNetworking<MovieCreditsResponseModel>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
    
    func fetchSimilar(movies id: Int) throws -> AnyPublisher<MoviesResponse, SPDNetworkError> {
        let url = try SPDNetworkURLBuilder()
            .set(operation: .similar(media: .movie, movieId: "\(id)"))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .build()
        
        return try SPDNetworking<MoviesResponse>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
    
    func fetchCreditDetails(creditId: String) throws -> AnyPublisher<MovieCastDetailsResponseModel, SPDNetworkError> {
        let url = try SPDNetworkURLBuilder()
            .set(operation: .creditDetails(creditId: creditId))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .build()
        
        return try SPDNetworking<MovieCastDetailsResponseModel>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
    
    func search(movie query: String, page: Int = 1) throws -> AnyPublisher<MoviesResponse, SPDNetworkError> {
        let url = try SPDNetworkURLBuilder()
            .set(operation: .search(media: .movie))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: "query", value: query)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try SPDNetworking<MoviesResponse>(url: url, method: .get).makeRequest()
            .eraseToAnyPublisher()
    }
}

extension WebServiceHandler {
    func setImage(urlString: String, completionHandler: @escaping(Result<Data, Error>)-> Void) {
        do {
            _ = try SPDNetworkURLBuilder()
                .set(poster: urlString)
                .buildImageURL()
            
//            NetworkManager().downloadImage(url: url, completionHandler: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
}

