//
//  WebServiceHandler.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

struct WebServiceHandler {
    func fetchPopularMovies(page: Int = 1, completionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
            .set(path: WebServiceConstats.kDatabaseVersion
                + WebServiceConstats.kMovie
                + OperationNameConstants.kPopular)
            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
            .build()
            NetworkManager(url: url, type: .get).request(onResult: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func fetchNowPlayingMovies(page: Int = 1, completionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                .set(path: WebServiceConstats.kDatabaseVersion
                    + WebServiceConstats.kMovie
                    + OperationNameConstants.kNowPlaying)
                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                .build()
            NetworkManager(url: url, type: .get).request(onResult: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func fetchUpcomingMovies(page: Int = 1,completionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kMovie + OperationNameConstants.kUpcoming)
                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                .build()
            
            NetworkManager(url: url, type: .get).request(onResult: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func fetchTopRatedMovies(page: Int = 1, completionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kMovie + OperationNameConstants.kTopRated)
                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                .build()
            
            NetworkManager(url: url, type: .get).request(onResult: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func fetchTrailerVideos(movie movieID: Int, completionHandler:@escaping(Result<MovieVideoResponse, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                .set(path: "\(movieID)" + WebServiceConstats.kVideos)
                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                .build()
            
            NetworkManager(url: url, type: .get).request(onResult: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func fetchTvTodaysAiring(page: Int = 1, completionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kTV + OperationNameConstants.kAiringToday)
                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                .build()
            
            NetworkManager(url: url, type: .get).request(onResult: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func fetchTvOnTheAir(page: Int = 1, completionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kTV + OperationNameConstants.kOnAir)
                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                .build()
            
            NetworkManager(url: url, type: .get).request(onResult: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func fetchTvPopular(page: Int = 1, completionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kTV + OperationNameConstants.kPopular)
                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                .build()
            
            NetworkManager(url: url, type: .get).request(onResult: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    func fetchTvTopRated(page: Int = 1, completionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kTV + OperationNameConstants.kTopRated)
                .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                .build()
            
            NetworkManager(url: url, type: .get).request(onResult: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    
}

extension WebServiceHandler {
    func setImage(urlString: String, completionHandler: @escaping(Result<Data, Error>)-> Void) {
        do {
            let url = try URLBuilder(scheme: WebServiceConstats.kScheme, host: "image.tmdb.org")
                .set(path: "t/p/w300_and_h300_bestv2" + urlString)
                .build()
            
            NetworkManager(url: url).downloadImage(completionHandler: completionHandler)
        } catch let error {
            completionHandler(.failure(error))
        }
    }
}

