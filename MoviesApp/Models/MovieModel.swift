//
//  MovieModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

struct PopularMoviesResponse: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page         = "page"
        case totalResults = "total_results"
        case totalPages   = "total_pages"
        case results      = "results"
    }
}

struct Movie: Hashable, Decodable, Identifiable {
    var id: Int
    
//    let movieID: Int
    let name: String
    let overview: String
    let poster: String
    let releaseDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case id     = "id"
        case name        = "title"
        case overview    = "overview"
        case poster      = "poster_path"
        case releaseDate = "release_date"
    }
}

struct MovieVideoResponse: Decodable {
    let movieID: Int
    let results: [MovieVideo]
    
    private enum CodingKeys: String, CodingKey {
        case movieID     = "id"
        case results     = "results"
        
    }
}

struct MovieVideo: Decodable, Identifiable {
    let id:    Int
    let videoKey:   String
    let videoName:  String
    let videoSite:  String
    let videoType:  String
    
    private enum CodingKeys: String, CodingKey {
        case id     = "id"
        case videoKey    = "key"
        case videoName   = "name"
        case videoSite   = "site"
        case videoType   = "type"
    }
}
