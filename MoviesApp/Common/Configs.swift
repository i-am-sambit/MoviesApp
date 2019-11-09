//
//  Configs.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 27/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

enum WebServiceConstats {
    static let kScheme          = "https"
    static let kHost            = "api.themoviedb.org"
    static let kDatabaseVersion = "3/"
    static let kMovie           = "movie/"
    static let kTV              = "tv/"
    static let kVideos          = "/videos"
}

enum QueryConstants {
    enum Keys {
        static let kAPIKey      = "api_key"
        static let kLanguage    = "language"
        static let kPage        = "page"
    }
    
    enum Values {
        static let kAPIKey      = "5a439649b46466212e07515d87737c1a"
        static let kLanguage    = "en-US"
    }
}

enum OperationNameConstants {
    static let kNowPlaying     = "now_playing"
    static let kPopular        = "popular"
    static let kUpcoming       = "upcoming"
    static let kTopRated       = "top_rated"
    static let kAiringToday    = "airing_today"
    static let kOnAir          = "on_the_air"
    
}
