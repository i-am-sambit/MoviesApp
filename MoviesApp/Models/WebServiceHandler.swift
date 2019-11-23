//
//  WebServiceHandler.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

struct WebServiceHandler {
    func fetchPopularMovies(page: Int = 1, complitionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        guard let url = URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                            .set(path: WebServiceConstats.kDatabaseVersion
                                     + WebServiceConstats.kMovie
                                     + OperationNameConstants.kPopular)
                            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                            .build()
        else { return }
        NetworkManager<MoviesResponse>(url: url, type: .get).request { (result) in
            complitionHandler(result)
        }
    }

    func fetchNowPlayingMovies(page: Int = 1, complitionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        guard let url = URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                            .set(path: WebServiceConstats.kDatabaseVersion
                                     + WebServiceConstats.kMovie
                                     + OperationNameConstants.kNowPlaying)
                            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                            .build()
        else { return }
        NetworkManager<MoviesResponse>(url: url, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchUpcomingMovies(page: Int = 1,complitionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        guard let url = URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                            .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kMovie + OperationNameConstants.kUpcoming)
                            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                            .build()
        else { return }
        NetworkManager<MoviesResponse>(url: url, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTopRatedMovies(page: Int = 1, complitionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        guard let url = URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                            .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kMovie + OperationNameConstants.kTopRated)
                            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                            .build()
        else { return }
        NetworkManager<MoviesResponse>(url: url, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTrailerVideos(movie movieID: Int, complitionHandler:@escaping(Result<MovieVideoResponse, Error>)-> Void) {
        guard let url = URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                            .set(path: "\(movieID)" + WebServiceConstats.kVideos)
                            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                            .build()
        else { return }
        NetworkManager<MovieVideoResponse>(url: url, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTvTodaysAiring(page: Int = 1, complitionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        guard let url = URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                            .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kTV + OperationNameConstants.kAiringToday)
                            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                            .build()
        else { return }
        NetworkManager<TVResponse>(url: url, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTvOnTheAir(page: Int = 1, complitionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        guard let url = URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                            .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kTV + OperationNameConstants.kOnAir)
                            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                            .build()
        else { return }
        NetworkManager<TVResponse>(url: url, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTvPopular(page: Int = 1, complitionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        guard let url = URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                            .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kTV + OperationNameConstants.kPopular)
                            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                            .build()
        else { return }
        NetworkManager<TVResponse>(url: url, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTvTopRated(page: Int = 1, complitionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        guard let url = URLBuilder(scheme: WebServiceConstats.kScheme, host: WebServiceConstats.kHost)
                            .set(path: WebServiceConstats.kDatabaseVersion + WebServiceConstats.kTV + OperationNameConstants.kTopRated)
                            .addQueryItem(name: QueryConstants.Keys.kAPIKey, value: QueryConstants.Values.kAPIKey)
                            .addQueryItem(name: QueryConstants.Keys.kLanguage, value: QueryConstants.Values.kLanguage)
                            .addQueryItem(name: QueryConstants.Keys.kPage, value: page)
                            .build()
        else { return }
        NetworkManager<TVResponse>(url: url, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    
}

