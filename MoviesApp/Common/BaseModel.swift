//
//  BaseModel.swift
//  MoviesApp
//
//  Created by Shakti Prakash Srichandan on 03/11/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import Foundation

struct BaseModel: Codable {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  private enum CodingKeys: String, CodingKey {
    case page         = "page"
    case totalResults = "total_results"
    case totalPages   = "total_pages"
  }
  init(from decoder: Decoder ) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    page = try container.decode(Int.self, forKey: .page)
    totalPages = try container.decode(Int.self, forKey: .totalPages)
    totalResults = try container.decode(Int.self, forKey: .totalResults)
  }
}

struct BaseContentInfoModel: Codable {
  var id: Int
  var name: String
  var overview: String
  var poster: String
  var releaseDate: String
  
  private enum CodingKeys: String, CodingKey {
    case id          = "id"
    case name        = "title"
    case overview    = "overview"
    case poster      = "poster_path"
    case releaseDate = "release_date"
  }
  init(from decoder: Decoder ) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    overview = try container.decode(String.self, forKey: .overview)
    poster = try container.decode(String.self, forKey: .poster)
    releaseDate = try container.decode(String.self, forKey: .releaseDate)
  }
  
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(id, forKey: .id)
//    try container.encode(name, forKey: .name)
//    try container.encode(overview, forKey: .overview)
//    try container.encode(poster, forKey: .poster)
//    try container.encode(releaseDate, forKey: .releaseDate)
//  }
}




