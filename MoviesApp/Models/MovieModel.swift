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
}



struct MoviesResponse: Decodable {
  let baseModel: BaseModel
  let results: [Movie]
  
  private enum CodingKeys: String, CodingKey {
    case results      = "results"
  }
  
  init(from decoder: Decoder ) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    baseModel =  try BaseModel(from: decoder)
    results = try container.decode([Movie].self, forKey: .results)
  }
  
}

struct Movie: MovieBaseProtocol, Hashable, Decodable {
  var id:          Int
  var name:        String
  var overview:    String
  var poster:      String
  var releaseDate: String
  
  private enum CodingKeys: String, CodingKey {
    case id          = "id"
    case name        = "title"
    case overview    = "overview"
    case poster      = "poster_path"
    case releaseDate = "release_date"
  }
}

struct TVResponse: Decodable {
  let baseModel: BaseModel
  let results: [TVAiring]
  
  private enum CodingKeys: String, CodingKey {
    case results      = "results"
  }
  init(from decoder: Decoder ) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     baseModel =  try BaseModel(from: decoder)
     results = try container.decode([TVAiring].self, forKey: .results)
   }
}

struct TVAiring: MovieBaseProtocol, Hashable, Decodable {
  var id:          Int
  var name:        String
  var overview:    String
  var poster:      String
  var releaseDate: String
  
  private enum CodingKeys: String, CodingKey {
    case id          = "id"
    case name        = "name"
    case overview    = "overview"
    case poster      = "poster_path"
    case releaseDate = "first_air_date"
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
