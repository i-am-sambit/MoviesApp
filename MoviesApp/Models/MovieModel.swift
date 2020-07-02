//
//  MovieModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

protocol MovieBaseProtocol {
    var id:          Int { get set }
    var name:        String { get set }
    var overview:    String { get set }
    var poster:      String { get set }
    var releaseDate: String { get set }
    var rating:      Double { get set }
    var popularity:  Int { get set }
}

class BaseMoviesResponse: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case page         = "page"
        case totalResults = "total_results"
        case totalPages   = "total_pages"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
    }
}

class MoviesResponse: BaseMoviesResponse {
    let results: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decodeIfPresent([Movie].self, forKey: .results) ?? []
        
        try super.init(from: decoder)
    }
}

struct Movie: MovieBaseProtocol, Hashable, Decodable {
    var id:          Int
    var name:        String
    var overview:    String
    var poster:      String
    var releaseDate: String
    var rating:      Double
    var popularity:  Int
    
    private enum CodingKeys: String, CodingKey {
        case id          = "id"
        case name        = "title"
        case overview    = "overview"
        case poster      = "poster_path"
        case releaseDate = "release_date"
        case rating      = "vote_average"
        case popularity  = "popularity"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        poster = try container.decodeIfPresent(String.self, forKey: .poster) ?? ""
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        rating = try container.decode(Double.self, forKey: .rating)
        popularity = Int(try container.decode(Double.self, forKey: .popularity))
    }
    
    init(id: Int, name: String, overview: String, poster: String, releaseDate: String, rating: Double, popularity: Int) {
        self.id = id
        self.name = name
        self.overview = name
        self.poster = name
        self.releaseDate = name
        self.rating = rating
        self.popularity = popularity
    }
}

struct TVResponse: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [TVAiring]
    
    private enum CodingKeys: String, CodingKey {
        case page         = "page"
        case totalResults = "total_results"
        case totalPages   = "total_pages"
        case results      = "results"
    }
}

struct TVAiring: Hashable, Decodable {
    var id:          Int
    var name:        String
    var overview:    String
    var poster:      String
    var releaseDate: String
    var rating:      String
    var popularity:  Int
    
    private enum CodingKeys: String, CodingKey {
        case id          = "id"
        case name        = "name"
        case overview    = "overview"
        case poster      = "poster_path"
        case releaseDate = "first_air_date"
        case rating      = "vote_average"
        case popularity  = "popularity"
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
    let id:         Int
    let videoKey:   String
    let videoName:  String
    let videoSite:  String
    let videoType:  String
    
    private enum CodingKeys: String, CodingKey {
        case id          = "id"
        case videoKey    = "key"
        case videoName   = "name"
        case videoSite   = "site"
        case videoType   = "type"
    }
}
