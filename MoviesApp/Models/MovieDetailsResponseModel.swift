//
//  MovieDetailsResponseModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 15/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation

struct MovieDetailsResponseModel: Decodable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [MovieGenre]
    let homepage: String
    let id: Int
    let originalTitle: String
    let overview: String
    let popularity: Int
    let posterPath: String
    let release: String
    let revenue: Int
    let runtime: Int
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let rating: String
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult, backdropPath = "backdrop_path", budget, genres, homepage, id, originalTitle = "original_title", overview, popularity, posterPath = "poster_path", release = "release_date", revenue, runtime, status, tagline, title, video, rating = "vote_average", voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        adult = try container.decode(Bool.self, forKey: .adult)
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
        budget = try container.decode(Int.self, forKey: .budget)
        genres = try container.decode([MovieGenre].self, forKey: .genres)
        homepage = try container.decode(String.self, forKey: .homepage)
        id = try container.decode(Int.self, forKey: .id)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = Int(try container.decode(Double.self, forKey: .popularity))
        posterPath = try container.decode(String.self, forKey: .posterPath)
        release = try container.decode(String.self, forKey: .release)
        revenue = try container.decode(Int.self, forKey: .revenue)
        runtime = try container.decode(Int.self, forKey: .runtime)
        status = try container.decode(String.self, forKey: .status)
        tagline = try container.decode(String.self, forKey: .tagline)
        title = try container.decode(String.self, forKey: .title)
        video = try container.decode(Bool.self, forKey: .video)
        let dRating = try container.decode(Float.self, forKey: .rating)
        
        self.rating = String(format: "%.1f", dRating)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
}

struct MovieGenre: Decodable {
    let id: Int
    let name: String
}

struct MovieCreditsResponseModel: Decodable {
    let id: Int
    let cast: [MovieCastModel]
}

struct MovieCastModel: Decodable {
    let castId: Int
    let character: String
    let creditId: String
    let gender: Int
    let id: Int
    let name: String
    let order: Int
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case castId = "cast_id", character, creditId = "credit_id", gender, id, name, order, posterPath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        castId = try container.decode(Int.self, forKey: .castId)
        character = try container.decode(String.self, forKey: .character)
        creditId = try container.decode(String.self, forKey: .creditId)
        gender = try container.decode(Int.self, forKey: .gender)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        order = try container.decode(Int.self, forKey: .order)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
    }
    
    init(castId: Int, character: String, creditId: String, gender: Int, id: Int, name: String, order: Int, posterPath: String) {
        self.castId = castId
        self.character = character
        self.creditId = creditId
        self.gender = gender
        self.id = id
        self.name = name
        self.order = order
        self.posterPath = posterPath
    }
}

