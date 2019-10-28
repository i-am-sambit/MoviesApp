//
//  WebServiceHandler.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

struct WebServiceHandler {
    func fetchPopularMovies(complitionHandler:@escaping(Result<PopularMoviesResponse, Error>)-> Void) {
        let urlString: String = "\(WebServiceConstats.endPoint)/popular?api_key=\(WebServiceConstats.kAPIKey)&language=en-US&page=1"
        
        NetworkManager<PopularMoviesResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }

    func fetchNowPlayingMovies(complitionHandler:@escaping(Result<PopularMoviesResponse, Error>)-> Void) {
        let urlString: String = "\(WebServiceConstats.endPoint)/now_playing?api_key=\(WebServiceConstats.kAPIKey)&language=en-US&page=1"
        
        NetworkManager<PopularMoviesResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchUpcomingMovies(complitionHandler:@escaping(Result<PopularMoviesResponse, Error>)-> Void) {
        let urlString: String = "\(WebServiceConstats.endPoint)/upcoming?api_key=\(WebServiceConstats.kAPIKey)&language=en-US&page=1"
        
        NetworkManager<PopularMoviesResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTopRatedMovies(complitionHandler:@escaping(Result<PopularMoviesResponse, Error>)-> Void) {
        let urlString: String = "\(WebServiceConstats.endPoint)/top_rated?api_key=\(WebServiceConstats.kAPIKey)&language=en-US&page=1"
        
        NetworkManager<PopularMoviesResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTrailerVideos(movie movieID: Int, complitionHandler:@escaping(Result<MovieVideoResponse, Error>)-> Void) {
        let urlString: String = "\(WebServiceConstats.endPoint)/\(movieID)/videos?api_key=\(WebServiceConstats.kAPIKey)&language=en-US"
        
        NetworkManager<MovieVideoResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
}

