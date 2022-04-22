//
//  MovieApi.swift
//  MovieApiFramework
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//
import Foundation
import Combine

public struct MovieApi{
    public enum Endpoint{
        case getGenres
        case getLatest
        case getNowPlaying(page: Int? = nil)
        case getPopular(page: Int? = nil)
        case getTopRated(page: Int? = nil)
        case getUpcoming(page: Int? = nil)
        case getSimilar(movieId: Int, page: Int? = nil)
        case getDetail(movieId: Int, appendToResponse: String? = nil)
        case getCredits(movieId: Int)
        case getImages(movieId: Int, includeImageLanguage: String? = nil)
        case getReviews(movieId: Int, page:Int? = nil)
        case getCountries
        case getLanguages
        case getTimeZones
        case getApiConfiguaration
        
        var path : String {
            switch self{
            case .getGenres:
                return "genre/movie/list"
            case .getLatest:
                return "movie/latest"
            case .getNowPlaying(_):
                return "movie/now_playing"
            case .getPopular(_):
                return "movie/popular"
            case .getTopRated(_):
                return "movie/top_rated"
            case .getUpcoming(_):
                return "movie/upcoming"
            case .getSimilar(let id, _):
                return "movie/\(id)/similar"
            case .getDetail(let id, _):
                return "movie/\(id)"
            case .getCredits(let id):
                return "movie/\(id)/credits"
            case .getImages(let id,_):
                return "movie/\(id)/images"
            case .getReviews(let id,_):
                return "movie/\(id)/reviews"
            case .getCountries:
                return "configuration/countries"
            case .getLanguages:
                return "configuration/languages"
            case .getTimeZones:
                return "configuration/timezones"
            case .getApiConfiguaration:
                return "configuration"
            }
        }
        
        var queryItems:[URLQueryItem]{
            switch self{
            case .getGenres:
                return []
            case .getLatest:
                return []
            case .getNowPlaying(let page),
                    .getPopular(let page),
                    .getTopRated(let page),
                    .getUpcoming(let page),
                    .getSimilar(_,let page),
                    .getReviews(_, let page):
                guard let page = page else{
                    return []
                }
                return [.init(name: "page", value: String(page))]
                
            case .getDetail(_, let appendToResponse):
                guard let appendToResponse = appendToResponse else{
                    return []
                }
                return [.init(name: "append_to_response", value: appendToResponse)]
            case .getCredits(_):
                return []
            case .getImages(_, let includeImageLanguage):
                guard let includeImageLanguage = includeImageLanguage else{
                    return []
                }
                return [.init(name: "include_image_language", value: includeImageLanguage)]
                
            case .getCountries:
                return []
            case .getLanguages:
                return []
            case .getTimeZones:
                return []
            case .getApiConfiguaration:
                return []
            }
        }
    }
    let baseUrl: URL
    let urlSession:URLSession
    let decoder:JSONDecoder
    let apiKey: String
    let language: String
    var commonQueryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "api_key", value: self.apiKey),
            URLQueryItem(name: "language", value: self.language)
        ]
    }
    public init(
        urlSession: URLSession,
        decoder: JSONDecoder,
        baseUrl: URL,
        apiKey: String,
        language: String = Locale.preferredLanguages[0]
    ){
        self.baseUrl = baseUrl
        self.apiKey = apiKey
        self.urlSession = urlSession
        self.decoder = decoder
        self.language = language
    }
    func createRequest(_ endpoint:Endpoint)->URLRequest?{
        guard let co = URLComponents(
            url: baseUrl.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: true
        ) else {
            return nil
        }
        var components = co
        components.queryItems = self.commonQueryItems
        components.queryItems?.append(contentsOf: endpoint.queryItems)
        guard let url = components.url else{
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    public func createPublisher<T: MovieApiResponse>(with endpoint:Endpoint)->AnyPublisher<T,MovieApiError>{
        guard let request = createRequest(endpoint) else{
            return Fail(error: MovieApiError.urlError)
                .eraseToAnyPublisher()
        }
        return self.urlSession.dataTaskPublisher(for: request)
        
            .tryMap(\.data)
            .decode(type: T.self, decoder: self.decoder)
            .mapError{
                error -> MovieApiError in
                switch error {
                case is DecodingError:
                    return .jsonDecodingError(error: error)
                default:
                    return .networkError(error: error)
                }
            }
            .eraseToAnyPublisher()
    }
}
