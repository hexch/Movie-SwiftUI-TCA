//
//  Movie+.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation
import MovieApiFramework
extension Movie{
    var baseUrl :String{ "https://image.tmdb.org/t/p/w500/"}
    var posterUrl: URL{
        URL(string: "\(baseUrl)\(poster_path ?? "")")!
    }
    var backdropUrl: URL{
        URL(string: "\(baseUrl)\(backdrop_path ?? "")")!
    }
}
