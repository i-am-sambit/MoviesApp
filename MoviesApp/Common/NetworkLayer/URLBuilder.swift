//
//  URLBuilder.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 09/11/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

class URLBuilder {
    private enum WebServiceConstats {
        static let kScheme          = "https"
        static let kHost            = "api.themoviedb.org"
        static let kImageHost       = "image.tmdb.org"
        static let kDatabaseVersion = "/3"
        static let kMovie           = "/movie"
        static let kTV              = "/tv"
        static let kImagePath       = "t/p/w300_and_h300_bestv2"
    }
    
    enum MediaType {
        case movie
        case tvSeries
    }
    
    enum ServiceOperation: String {
        case nowPlaying     = "/now_playing"
        case popular        = "/popular"
        case upcoming       = "/upcoming"
        case topRated       = "/top_rated"
        case airingToday    = "/airing_today"
        case onAir          = "/on_the_air"
        case videos         = "/videos"
    }
    
    private lazy var components: URLComponents = URLComponents()
    private lazy var mediaPath:  String = ""
    private lazy var operation:  String = ""
    private lazy var mediaId:    String = ""
    private lazy var posterPath: String = ""
    
    func set(media mediaType: MediaType) -> URLBuilder {
        self.mediaPath = mediaType == .movie ? WebServiceConstats.kMovie : WebServiceConstats.kTV
        return self
    }
    
    func set(operation: ServiceOperation) -> URLBuilder {
        self.operation = operation.rawValue
        return self
    }
    
    func set(media mediaId: String) -> URLBuilder {
        self.mediaId = mediaId
        return self
    }
    
    func set(poster path: String) -> URLBuilder {
        self.posterPath = path
        return self
    }
    
    func addQueryItem<Element>(name: String, value: Element) -> URLBuilder  {
        if self.components.queryItems == nil {
            self.components.queryItems = []
        }
        self.components.queryItems?.append(URLQueryItem(name: name, value: "\(value)"))
        return self
    }
    
    func build() throws -> URL {
        self.components.scheme = WebServiceConstats.kScheme
        self.components.host = WebServiceConstats.kHost
        self.components.path = WebServiceConstats.kDatabaseVersion + self.mediaPath + self.operation
        
        guard let url = self.components.url else {
            throw MDBErrorManager.badURL
        }
        
        return url
    }
    
    func buildImageURL() throws -> URL {
        self.components.scheme = WebServiceConstats.kScheme
        self.components.host = WebServiceConstats.kHost
        self.components.path = WebServiceConstats.kImagePath + self.posterPath
        
        guard let url = self.components.url else {
            throw MDBErrorManager.badURL
        }
        
        return url
    }
}
