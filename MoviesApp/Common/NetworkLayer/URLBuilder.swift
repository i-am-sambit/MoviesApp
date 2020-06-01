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
        static let kImagePath       = "/t/p/w300_and_h300_bestv2"
    }
    
//    enum MediaType {
//        case movie
//        case tvSeries
//    }
    
    private lazy var components: URLComponents = URLComponents()
//    private lazy var mediaPath:  String = ""
    private lazy var operation:  String = ""
    private lazy var mediaId:    String = ""
    private lazy var posterPath: String = ""
    
//    func set(media mediaType: MediaType) -> URLBuilder {
//        self.mediaPath = mediaType == .movie ? WebServiceConstats.kMovie : WebServiceConstats.kTV
//        return self
//    }
    
    func set(operation: ServiceOperation) -> URLBuilder {
        self.operation = operation.value
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
        self.components.path = WebServiceConstats.kDatabaseVersion + self.operation
        
        guard let url = self.components.url else {
            throw MDBErrorManager.badURL
        }
        
        return url
    }
    
    func buildImageURL() throws -> URL {
        self.components.scheme = WebServiceConstats.kScheme
        self.components.host = WebServiceConstats.kImageHost
        self.components.path = WebServiceConstats.kImagePath + self.posterPath
        
        guard let url = self.components.url else {
            throw MDBErrorManager.badURL
        }
        
        return url
    }
}

extension URLBuilder {
    enum ServiceOperation {
        case trending(timeWindow: Trending)
        case nowPlaying
        case popular
        case upcoming
        case topRated
        
        var value: String {
            switch self {
                
            case .trending(timeWindow: let timeWindow):
                switch timeWindow {
                
                case .day:
                    return "/trending/movie/day"
                case .week:
                    return "/trending/movie/week"
                }
            case .nowPlaying:
                return "/movie/now_playing"
            case .popular:
                return "/movie/popular"
            case .upcoming:
                return "/movie/upcoming"
            case .topRated:
                return "/movie/top_rated"
            }
        }
        
    }
    
    enum Trending: String {
        case day    = "/day"
        case week   = "/week"
    }
}
