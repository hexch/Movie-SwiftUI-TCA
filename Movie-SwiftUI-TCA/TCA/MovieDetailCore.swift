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
    var loading = false
    
    let movieId: Int
    let title:String
    var backdropUrl: URL
    var releaseDate: String?
    var runtime: Int?
    var rating: Float?
    var voteCount: Int?
    var genres: [Genre]
    
    var overview:String
    
    init(movie:Movie){
        movieId = movie.id
        backdropUrl = movie.backdropUrl
        releaseDate = movie.release_date
        runtime = movie.runtime
        rating = movie.vote_average
        voteCount = movie.vote_count
        genres = movie.genres ?? []
        title = movie.title
        overview = movie.overview
    }
}
enum MovieDetailAction{
    case load
    case loaded(Result<Movie,MovieApiError>)
}
let movieDetailReducer = Reducer<MovieDetailState,MovieDetailAction,GlobalEveroment>{
    state,action,enviroment in
    
    switch action{
    case .load:
        struct CancelableId:Hashable{}
        
        state.loading = true
        return enviroment.movieApiClient
            .getMovieDetailPublisher(state.movieId)
            .receive(on: enviroment.mainQueue)
            .catchToEffect(MovieDetailAction.loaded)
            .cancellable(id: CancelableId())
    case let .loaded(.failure(error)):
        state.loading = false
        return .none
    case let .loaded(.success(movie)):
        state.loading = false
        state.genres = movie.genres ?? []
        state.overview = movie.overview
        return .none
    }
}.debug()
