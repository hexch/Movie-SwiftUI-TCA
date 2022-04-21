//
//  Test-MovieApi.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation
import Combine
import MovieApiFramework
import ComposableArchitecture

struct TestAppState:Equatable{
    var loadingGenres:Bool = false
    var genres:[Genre] = []
}
enum TestAppAction{
    case loadGenres
    case genresLoaded(Result<GenresResponse,MovieApiError>)
    
}
struct TestAppEnveroment{
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var movieApiClient: MovieApi
    static let live = TestAppEnveroment(
        mainQueue: .main,
        movieApiClient: .shared
    )
}
let testAppReducer = Reducer<TestAppState,TestAppAction,TestAppEnveroment>{
    state,action,env in
    switch action{
    case .loadGenres:
        struct CancelableId:Hashable{}
        state.loadingGenres = true
        
        return env.movieApiClient.getGenresPublisher
            .receive(on: env.mainQueue)
            .eraseToEffect()
            .catchToEffect(TestAppAction.genresLoaded)
            .cancellable(id: CancelableId(), cancelInFlight: true)
    case let .genresLoaded(.failure(error)):
        state.loadingGenres = false
        state.genres = []
        return .none
    case let .genresLoaded(.success(response)):
        state.loadingGenres = false
        state.genres = response.genres
        return .none
    }
}
