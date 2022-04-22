//
//  MovieDetailCore.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/22.
//

import Foundation
import MovieApiFramework
import ComposableArchitecture

struct MovieDetailState:Equatable{
    var movie: Movie
}
struct MovieDetailPeopleState: Equatable{
    let movieId:Int
    var crews: [People] = []
    var casts: [People] = []
}

enum MovieDetailAction{
    case load
    case loaded(Result<Movie,MovieApiError>)
}
enum MovieDetailPeopleAction{
    case load
    case loaded(Result<CastResponse,MovieApiError>)
}
let movieDetailPeopleReducer = Reducer<MovieDetailPeopleState,MovieDetailPeopleAction,GlobalEveroment>{
    state, action, enviroment in
    switch action {
    case .load:
        struct CancelableId:Hashable{}
        
        return enviroment.movieApiClient
            .getCreditPublisher(state.movieId)
            .receive(on: enviroment.mainQueue)
            .catchToEffect(MovieDetailPeopleAction.loaded)
            .cancellable(id: CancelableId())
    case let .loaded(.failure(error)):
        print(error)
        return .none
    case let .loaded(.success(response)):
        print(response)
        state.casts = response.cast
        state.crews = response.crew
        return .none
    }
}
let movieDetailReducer = Reducer<MovieDetailState,MovieDetailAction,GlobalEveroment>{
    state,action,enviroment in
    
    switch action{
    case .load:
        struct CancelableId:Hashable{}
        
        return enviroment.movieApiClient
            .getMovieDetailPublisher(state.movie.id)
            .receive(on: enviroment.mainQueue)
            .catchToEffect(MovieDetailAction.loaded)
            .cancellable(id: CancelableId())
    case let .loaded(.failure(error)):
        return .none
    case let .loaded(.success(movie)):
        state.movie = movie
        return .none
    }
}
