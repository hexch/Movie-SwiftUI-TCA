//
//  MovieApi+.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation
import MovieApiFramework

extension MovieApi{
    static let shared = MovieApi(
        urlSession: .shared,
        decoder: JSONDecoder(),
        baseUrl: URL(string: "https://api.themoviedb.org/3")!,
        apiKey: "2cbc7e68dc9b20f28644bae3a5f10b57"
    )
}
