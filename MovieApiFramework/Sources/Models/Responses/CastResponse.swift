//
//  CastResponse.swift
//  MovieApiFramework
//
//  Created by XIAOCHUAN HE on R 4/04/22.
//

import Foundation

public struct CastResponse: Codable,MovieApiResponse {
    public let id: Int
    public let cast: [People]
    public let crew: [People]
}

public extension CastResponse{
    static let sample = [People(id: 0,
                                name: "Cast 1",
                                character: "Character 1",
                                department: nil,
                                profile_path: "/2UIRf34DnLl59Qir4Q2kNVoBjYN.jpg",
                                known_for_department: "Acting",
                                known_for: [
                                    People.KnownFor(
                                        id: Movie.sample.id,
                                        original_title:  Movie.sample.original_title,
                                        poster_path:  Movie.sample.poster_path
                                    )
                                ],
                                also_known_as: nil, birthDay: nil,
                                deathDay: nil, place_of_birth: nil,
                                biography: nil, popularity: nil, images: nil),
                         People(id: 1, name: "Cast 2", character: nil, department: "Director 1", profile_path: "/2daC5DeXqwkFND0xxutbnSVKN6c.jpg",
                                known_for_department: "Acting", known_for: nil,
                                also_known_as: nil, birthDay: nil, deathDay: nil, place_of_birth: nil,
                                biography: nil, popularity: nil, images: nil)]
    
}
