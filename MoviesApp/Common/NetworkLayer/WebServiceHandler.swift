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
    
//    func fetchTrailerVideos(movie movieID: Int, completionHandler:@escaping(Result<MovieVideoResponse, Error>)-> Void) {
//        do {
//            let url = try URLBuilder()
//                .set(media: .movie)
//                .set(media: "\(movieID)")
//                .set(operation: .videos)
//                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
//                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
//                .build()
//            
//            networkManager.make(url: url, requestType: .get, completionHandler: completionHandler)
//        } catch let error {
//            completionHandler(.failure(error))
//        }
//    }
//    
//    func fetchTvTodaysAiring(page: Int = 1, completionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
//        do {
//            let url = try URLBuilder()
//                .set(media: .tvSeries)
//                .set(operation: .airingToday)
//                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
//                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
//                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
//                .build()
//            
//            networkManager.make(url: url, requestType: .get, completionHandler: completionHandler)
//        } catch let error {
//            completionHandler(.failure(error))
//        }
//    }
//    
//    func fetchTvOnTheAir(page: Int = 1, completionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
//        do {
//            let url = try URLBuilder()
//                .set(media: .tvSeries)
//                .set(operation: .onAir)
//                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
//                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
//                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
//                .build()
//            
//            networkManager.make(url: url, requestType: .get, completionHandler: completionHandler)
//        } catch let error {
//            completionHandler(.failure(error))
//        }
//    }
//    
//    func fetchTvPopular(page: Int = 1, completionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
//        do {
//            let url = try URLBuilder()
//                .set(media: .tvSeries)
//                .set(operation: .popular)
//                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
//                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
//                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
//                .build()
//            
//            networkManager.make(url: url, requestType: .get, completionHandler: completionHandler)
//        } catch let error {
//            completionHandler(.failure(error))
//        }
//    }
//    
//    func fetchTvTopRated(page: Int = 1, completionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
//        do {
//            let url = try URLBuilder()
//                .set(media: .tvSeries)
//                .set(operation: .topRated)
//                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
//                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
//                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
//                .build()
//            
//            networkManager.make(url: url, requestType: .get, completionHandler: completionHandler)
//        } catch let error {
//            completionHandler(.failure(error))
//        }
//    }
    
    
}

extension WebServiceHandler {
    func setImage(urlString: String, completionHandler: @escaping(Result<Data, Error>)-> Void) {
        do {
            let url = try URLBuilder()
                .set(poster: urlString)
                .buildImageURL()
            
//            NetworkManager().downloadImage(url: url, completionHandler: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
}

