//
//  MovieApi+.swift
//  MovieApiFramework
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation
import Combine

public extension MovieApi{
    var getGenresPublisher: AnyPublisher<GenresResponse, MovieApiError> {
        createPublisher(with: .getGenres)
    }
    var getLatestPublisher: AnyPublisher<Movie, MovieApiError> {
        createPublisher(with: .getLatest)
    }
    func getNowPlayingPublisher(_ page:Int) -> AnyPublisher<PaginatedResponse<Movie>, MovieApiError>{
        createPublisher(with: .getNowPlaying(page: page))
    }
    func getPopularPublisher(_ page:Int) -> AnyPublisher<PaginatedResponse<Movie>, MovieApiError>{
        createPublisher(with: .getPopular(page: page))
    }
    func getTopRatedPublisher(_ page:Int) -> AnyPublisher<PaginatedResponse<Movie>, MovieApiError>{
        createPublisher(with: .getTopRated(page: page))
    }
    func getUpcomingPublisher(_ page:Int) -> AnyPublisher<PaginatedResponse<Movie>, MovieApiError>{
        createPublisher(with: .getUpcoming(page: page))
    }
}
