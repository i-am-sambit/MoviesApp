//
//  WebServiceHandler.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

struct WebServiceHandler {
    func fetchPopularMovies(complitionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        let urlString: String = WebServiceConstats.kEndPoint + WebServiceConstats.kMovie + OperationNameConstants.kPopular + "?api_key=" + WebServiceConstats.kAPIKey + "&language=en-US&page=1"
        
        NetworkManager<MoviesResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }

    func fetchNowPlayingMovies(complitionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        let urlString: String = WebServiceConstats.kEndPoint + WebServiceConstats.kMovie + OperationNameConstants.kNowPlaying + "?api_key=" + WebServiceConstats.kAPIKey + "&language=en-US&page=1"
        
        NetworkManager<MoviesResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchUpcomingMovies(complitionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        let urlString: String = WebServiceConstats.kEndPoint + WebServiceConstats.kMovie + OperationNameConstants.kUpcoming + "?api_key=" + WebServiceConstats.kAPIKey + "&language=en-US&page=1"
        
        NetworkManager<MoviesResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTopRatedMovies(complitionHandler:@escaping(Result<MoviesResponse, Error>)-> Void) {
        let urlString: String = WebServiceConstats.kEndPoint + WebServiceConstats.kMovie + OperationNameConstants.kTopRated + "?api_key=" + WebServiceConstats.kAPIKey + "&language=en-US&page=1"
        
        NetworkManager<MoviesResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTrailerVideos(movie movieID: Int, complitionHandler:@escaping(Result<MovieVideoResponse, Error>)-> Void) {
        let urlString: String = "\(WebServiceConstats.kEndPoint)/\(movieID)/videos?api_key=\(WebServiceConstats.kAPIKey)&language=en-US"
        
        NetworkManager<MovieVideoResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTvTodaysAiring(complitionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        let urlString: String = (WebServiceConstats.kEndPoint) + WebServiceConstats.kTV + OperationNameConstants.kAiringToday + "?api_key=" + WebServiceConstats.kAPIKey + "&language=en-US&page=1"
        
        NetworkManager<TVResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTvOnTheAir(complitionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        let urlString: String = (WebServiceConstats.kEndPoint) + WebServiceConstats.kTV + OperationNameConstants.kOnAir + "?api_key=" + WebServiceConstats.kAPIKey + "&language=en-US&page=1"
        
        NetworkManager<TVResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTvPopular(complitionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        let urlString: String = (WebServiceConstats.kEndPoint) + WebServiceConstats.kTV + OperationNameConstants.kPopular + "?api_key=" + WebServiceConstats.kAPIKey + "&language=en-US&page=1"
        
        NetworkManager<TVResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    func fetchTvTopRated(complitionHandler:@escaping(Result<TVResponse, Error>)-> Void) {
        let urlString: String = (WebServiceConstats.kEndPoint) + WebServiceConstats.kTV + OperationNameConstants.kTopRated + "?api_key=" + WebServiceConstats.kAPIKey + "&language=en-US&page=1"
        
        NetworkManager<TVResponse>(urlString: urlString, type: .get).request { (result) in
            complitionHandler(result)
        }
    }
    
    
}

