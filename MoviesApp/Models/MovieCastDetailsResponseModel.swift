//
//  MovieCastDetailsResponseModel.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 16/06/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation

struct MovieCastDetailsResponseModel: Decodable {
    let creditType: String
    let department: String
    let job: String
    let id: String
    let person: PersonModel
    
    enum CodingKeys: String, CodingKey {
        case creditType = "credit_type", department, job, id, person
    }
}

struct PersonModel: Decodable {
    let knownForDepartment: String
    let adult: Bool
    let id: Int
    let profilePath: String
    let name: String
    let knownFor: [Movie]
    let gender: Int
    let popularity: Int
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department", adult, id, profilePath = "profile_path", name, knownFor = "known_for", gender, popularity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
        adult = try container.decode(Bool.self, forKey: .adult)
        id = try container.decode(Int.self, forKey: .id)
        profilePath = try container.decode(String.self, forKey: .profilePath)
        name = try container.decode(String.self, forKey: .name)
        knownFor = try container.decode([Movie].self, forKey: .knownFor)
        gender = try container.decode(Int.self, forKey: .gender)
        popularity = Int(try container.decode(Double.self, forKey: .popularity))
    }
}


