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
        movieApiClient: MovieApi(
            urlSession: .shared,
            decoder: JSONDecoder(),
            baseUrl: URL(string: "https://api.themoviedb.org/3")!,
            apiKey: "2cbc7e68dc9b20f28644bae3a5f10b57"
        )
    )
}
let testAppReducer = Reducer<TestAppState,TestAppAction,TestAppEnveroment>{
    state,action,env in
    switch action{
    case .loadGenres:
        struct CancelableId:Hashable{}
        state.loadingGenres = true
        let publisher:AnyPublisher<GenresResponse,MovieApiError> =
            env.movieApiClient.createPublisher(with: .getGenres)
        
        return publisher
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
