//
//  WebServiceHandler.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation
import Combine

final class WebServiceHandler {
    func fetchTrendingMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, Error> {
        let url = try URLBuilder()
            .set(operation: .trending(timeWindow: .day))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try NetworkManager<MoviesResponse>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MoviesResponse, Error>(error: error) }
            .eraseToAnyPublisher()
    }
    
    func fetchPopularMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, Error> {
        let url = try URLBuilder()
            .set(operation: .popular)
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try NetworkManager<MoviesResponse>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MoviesResponse, Error>(error: error) }
            .eraseToAnyPublisher()
    }
    
    func fetchNowPlayingMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, Error> {
        let url = try URLBuilder()
            .set(operation: .nowPlaying)
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try NetworkManager<MoviesResponse>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MoviesResponse, Error>(error: error) }
            .eraseToAnyPublisher()
    }
    
    func fetchUpcomingMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, Error> {
        
        let url = try URLBuilder()
            .set(operation: .upcoming)
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try NetworkManager<MoviesResponse>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MoviesResponse, Error>(error: error) }
            .eraseToAnyPublisher()
    }
    
    func fetchTopRatedMovies(page: Int = 1) throws -> AnyPublisher<MoviesResponse, Error> {
        let url = try URLBuilder()
            .set(operation: .topRated)
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try NetworkManager<MoviesResponse>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MoviesResponse, Error>(error: error) }
            .eraseToAnyPublisher()
    }
    
    func fetchDetails(movie id: Int) throws -> AnyPublisher<MovieDetailsResponseModel, Error> {
        let url = try URLBuilder()
            .set(operation: .details(media: .movie, movieId: "\(id)"))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .build()
        
        return try NetworkManager<MovieDetailsResponseModel>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MovieDetailsResponseModel, Error>(error: error) }
            .eraseToAnyPublisher()
    }
    
    func fetchCredits(movie id: Int) throws -> AnyPublisher<MovieCreditsResponseModel, Error> {
        let url = try URLBuilder()
            .set(operation: .credits(media: .movie, movieId: "\(id)"))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .build()
        
        return try NetworkManager<MovieCreditsResponseModel>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MovieCreditsResponseModel, Error>(error: error) }
            .eraseToAnyPublisher()
    }
    
    func fetchSimilar(movies id: Int) throws -> AnyPublisher<MoviesResponse, Error> {
        let url = try URLBuilder()
            .set(operation: .similar(media: .movie, movieId: "\(id)"))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .build()
        
        return try NetworkManager<MoviesResponse>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MoviesResponse, Error>(error: error) }
            .eraseToAnyPublisher()
    }
    
    func fetchCreditDetails(creditId: String) throws -> AnyPublisher<MovieCastDetailsResponseModel, Error> {
        let url = try URLBuilder()
            .set(operation: .creditDetails(creditId: creditId))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .build()
        
        return try NetworkManager<MovieCastDetailsResponseModel>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MovieCastDetailsResponseModel, Error>(error: error) }
            .eraseToAnyPublisher()
    }
    
    func search(movie query: String, page: Int = 1) throws -> AnyPublisher<MoviesResponse, Error> {
        let url = try URLBuilder()
            .set(operation: .search(media: .movie))
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: "query", value: query)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
        
        return try NetworkManager<MoviesResponse>(url: url, method: .get).makeRequest()
            .catch { (error) in Fail<MoviesResponse, Error>(error: error) }
            .eraseToAnyPublisher()
    }
}

extension WebServiceHandler {
    func setImage(urlString: String, completionHandler: @escaping(Result<Data, Error>)-> Void) {
        do {
            _ = try URLBuilder()
                .set(poster: urlString)
                .buildImageURL()
            
//            NetworkManager().downloadImage(url: url, completionHandler: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
}

