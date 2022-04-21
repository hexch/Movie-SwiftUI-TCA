//
//  GlobalEnveroment.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//
import Foundation
import ComposableArchitecture
import MovieApiFramework

struct GlobalEveroment{
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var movieApiClient: MovieApi
    static let live = GlobalEveroment(mainQueue: .main, movieApiClient: .shared)
}
