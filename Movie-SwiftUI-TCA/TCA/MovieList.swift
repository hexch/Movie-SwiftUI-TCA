//
//  MoviePosters.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation
import Combine
import MovieApiFramework
import ComposableArchitecture

struct MovieListState:Equatable{
    var loading = false
    var paginatedResponse :PaginatedResponse<Movie>? = nil
    var movieDetailState:MovieDetailState?
    
    var movies:[Movie] {
        paginatedResponse?.results ?? []
    }
    var currentPage:Int{
        paginatedResponse?.page ?? 0 + 1
    }
}

enum MovieListAction{
    case load
    case loaded(Result<PaginatedResponse<Movie>,MovieApiError>)
    case presentDetail(Movie?)
    case movieDetail(MovieDetailAction)
}
protocol MovieListEnveroment{
    var global: GlobalEveroment {get set}
    var publisher: (Int)-> AnyPublisher<PaginatedResponse<Movie>, MovieApiError> { get }
}
struct PopularMovieListEnveroment:MovieListEnveroment{
    var global: GlobalEveroment = .live
    var publisher : (Int)-> AnyPublisher<PaginatedResponse<Movie>, MovieApiError>{
        global.movieApiClient.getPopularPublisher(_:)
    }
}
struct TopRatedMovieListEnveroment:MovieListEnveroment{
    var global: GlobalEveroment = .live
    var publisher : (Int)-> AnyPublisher<PaginatedResponse<Movie>, MovieApiError>{
        global.movieApiClient.getTopRatedPublisher(_:)
    }
}
struct UpcomingMovieListEnveroment:MovieListEnveroment{
    var global: GlobalEveroment = .live
    var publisher : (Int)-> AnyPublisher<PaginatedResponse<Movie>, MovieApiError>{
        global.movieApiClient.getUpcomingPublisher(_:)
    }
}
struct NowPlayingMovieListEnveroment:MovieListEnveroment{
    var global: GlobalEveroment = .live
    var publisher : (Int)-> AnyPublisher<PaginatedResponse<Movie>, MovieApiError>{
        global.movieApiClient.getNowPlayingPublisher(_:)
    }
}

let movieListReducer  = Reducer<MovieListState, MovieListAction, MovieListEnveroment>.combine(
    movieDetailReducer
        .optional()
        .pullback(
            state: \.movieDetailState,
            action: /MovieListAction.movieDetail,
            environment: {$0.global}
        ),
    Reducer{
        state,action,enveroment in
        
        switch action {
        case .load:
            guard state.paginatedResponse == nil else{
                return .none
            }
            struct CancelableId: Hashable {}
            
            state.loading = true
            return enveroment
                .publisher(state.currentPage)
                .receive(on: enveroment.global.mainQueue)
                .catchToEffect(MovieListAction.loaded)
                .cancellable(id: CancelableId())
        case let .loaded(.failure(error)):
            state.loading = false
            return .none
        case let .loaded(.success(response)):
            state.loading = false
            state.paginatedResponse = response
            return .none
        case .presentDetail(let movie):
            if let movie = movie{
                state.movieDetailState = .init(movie: movie)
            }else{
                state.movieDetailState = nil
            }
            
            return .none
        case .movieDetail:
            return .none
        }
    }.debug()
)
