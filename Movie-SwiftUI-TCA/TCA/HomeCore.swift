//
//  HomeCore.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation
import ComposableArchitecture
struct HomeState: Equatable{
    var upcoming: MovieListState = .init()
    var toprated: MovieListState = .init()
    var nowplaying: MovieListState = .init()
    var popular: MovieListState = .init()
}

enum HomeAction{
    case popular(MovieListAction)
    case upcoming(MovieListAction)
    case topRated(MovieListAction)
    case nowPlaying(MovieListAction)
}
struct HomeEnveroment{
    var global :GlobalEveroment = .live
}

let homeReducer = Reducer<HomeState,HomeAction,HomeEnveroment>.combine(
    movieListReducer.pullback(
        state: \.popular,
        action: /HomeAction.popular,
        environment: {env in PopularMovieListEnveroment(global: env.global)}
    ),
    movieListReducer.pullback(
        state: \.toprated,
        action: /HomeAction.topRated,
        environment: {env in TopRatedMovieListEnveroment(global: env.global)}
    ),
    movieListReducer.pullback(
        state: \.upcoming,
        action: /HomeAction.upcoming,
        environment: {env in UpcomingMovieListEnveroment(global: env.global)}
    ),
    movieListReducer.pullback(
        state: \.nowplaying,
        action: /HomeAction.nowPlaying,
        environment: {env in NowPlayingMovieListEnveroment(global: env.global)}
    )
)
