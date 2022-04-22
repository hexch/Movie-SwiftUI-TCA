import UIKit
import Combine
import MovieApiFramework
var greeting = "Hello, playground"
print(greeting)

let movieApi = 
MovieApi(
    urlSession: .shared,
    decoder: JSONDecoder(),
    baseUrl: URL(string: "https://api.themoviedb.org/3")!,
    apiKey: "2cbc7e68dc9b20f28644bae3a5f10b57"
)

let latestPublisher: AnyPublisher<Movie,MovieApiError> = movieApi.createPublisher(with: .getLatest)
var cancelables:[AnyCancellable] = []

latestPublisher.receive(on: RunLoop.main)
    .sink(
        receiveCompletion: {completion in
            print(completion)
        },
        receiveValue: {movie in
            print(movie)
        }
    ).store(in: &cancelables)

let popularPublisher :AnyPublisher<PaginatedResponse<Movie>,MovieApiError> = movieApi.createPublisher(with: .getPopular(page: 1))

popularPublisher.receive(on: RunLoop.main)
    .sink(
        receiveCompletion: {
            completion in
            print(completion)
        },
        receiveValue: {
            response in
            print(response)
        }
    ).store(in: &cancelables)

movieApi.getCreditPublisher(568124)
    .receive(on: RunLoop.main)
    .sink(
        receiveCompletion: {
            completion in
            print(completion)
        },
        receiveValue: {
            response in
            print(response)
        }
    ).store(in: &cancelables)
