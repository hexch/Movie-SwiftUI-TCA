//
//  MovieApiTests.swift
//  MovieApiFrameworkTests
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import XCTest
import Combine
@testable import MovieApiFramework

class MovieApiTests: XCTestCase {
    let testTimeout :TimeInterval = 3 //seconds
    let baseURL = URL(string: "https://test")!
    let apiKey = "012345"
    let language = "ja-JP"
    var movieApi : MovieApi{
        MovieApi(
            urlSession: .shared,
            decoder: JSONDecoder(),
            baseUrl: baseURL,
            apiKey: apiKey,
            language: language
        )
    }
    
    var cancelableStore :[AnyCancellable] = []
    
    override class func setUp() {
        super.setUp()
        LSNocilla.sharedInstance().start()
    }
    
    override class func tearDown() {
        LSNocilla.sharedInstance().stop()
        super.tearDown()
    }
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        LSNocilla.sharedInstance().clearStubs()
    }
    func testCreateRequest() throws{
        let query = "?api_key=\(apiKey)&language=\(language)"
        XCTAssertEqual(
            movieApi.createRequest(.getGenres)?.url?.absoluteString,
            "\(baseURL.absoluteString)/genre/movie/list\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getLatest)?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/latest\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getNowPlaying(page: 1))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/now_playing\(query)&page=1"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getNowPlaying())?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/now_playing\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getPopular(page: 1))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/popular\(query)&page=1"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getPopular())?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/popular\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getTopRated(page: 1))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/top_rated\(query)&page=1"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getTopRated())?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/top_rated\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getUpcoming(page: 1))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/upcoming\(query)&page=1"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getUpcoming())?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/upcoming\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getSimilar(movieId: 2, page: 3))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/2/similar\(query)&page=3"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getSimilar(movieId: 2))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/2/similar\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getDetail(movieId: 1, appendToResponse: "atr"))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/1\(query)&append_to_response=atr"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getDetail(movieId: 1))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/1\(query)"
        )
        
        XCTAssertEqual(
            movieApi.createRequest(.getCredits(movieId: 1))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/1/credits\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getImages(movieId: 1, includeImageLanguage: "en-US"))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/1/images\(query)&include_image_language=en-US"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getImages(movieId: 1))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/1/images\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getReviews(movieId: 2, page: 5))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/2/reviews\(query)&page=5"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getReviews(movieId: 2))?.url?.absoluteString,
            "\(baseURL.absoluteString)/movie/2/reviews\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getCountries)?.url?.absoluteString,
            "\(baseURL.absoluteString)/configuration/countries\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getLanguages)?.url?.absoluteString,
            "\(baseURL.absoluteString)/configuration/languages\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getTimeZones)?.url?.absoluteString,
            "\(baseURL.absoluteString)/configuration/timezones\(query)"
        )
        XCTAssertEqual(
            movieApi.createRequest(.getApiConfiguaration)?.url?.absoluteString,
            "\(baseURL.absoluteString)/configuration\(query)"
        )
        
    }
    func testCreateRequestError() throws{
        let e1MovieApi = MovieApi(
            urlSession: .shared,
            decoder: JSONDecoder(),
            baseUrl: URL(string: "https://test:-80")!,
            apiKey: apiKey
        )
        XCTAssertNil(e1MovieApi.createRequest(.getGenres))
    }
    func testGetGenres() throws{
        let expectation = expectation(description: #function)
        let request = movieApi.createRequest(.getGenres)!
        let testGenres :GenresResponse = .init(genres: [
            .init(id: 1, name: "test1"),
            .init(id: 2, name: "test2")
        ])
        let testData:Data  = try! JSONEncoder().encode(testGenres)
        stub(request.url!, data: testData)
        let publisher :AnyPublisher<GenresResponse,MovieApiError> =
        movieApi.createPublisher(with: .getGenres)
        publisher.sink(
            receiveCompletion: {_ in
                expectation.fulfill()
            },
            receiveValue: {value in
                XCTAssertEqual(value, testGenres)
            }
        ).store(in: &cancelableStore)
        waitForExpectations(timeout: testTimeout, handler: nil)
    }
    
    func testCreatePublisher_Error_urlError() throws{
        let expectation = expectation(description: #function)
        let e1MovieApi = MovieApi(
            urlSession: .shared,
            decoder: JSONDecoder(),
            baseUrl: URL(string: "https://test:-80")!,
            apiKey: apiKey
        )
        let publisher :AnyPublisher<GenresResponse,MovieApiError> = e1MovieApi.createPublisher(with: .getGenres)
        publisher.sink(
            receiveCompletion: {completion in
                guard case Subscribers.Completion<MovieApiError>.failure(MovieApiError.urlError) = completion else{
                    XCTFail()
                    expectation.fulfill()
                    return
                }
                expectation.fulfill()
            },
            receiveValue: {_ in }
        ).store(in: &cancelableStore)
        waitForExpectations(timeout: testTimeout, handler: nil)
    }
    
    func testCreatePublisher_Error_DecodeError() throws{
        let expectation = expectation(description: #function)
        let request = movieApi.createRequest(.getGenres)!
        let testData:Data  = "test".data(using: .utf8)!
        stub(request.url!, data: testData)
        let publisher :AnyPublisher<GenresResponse,MovieApiError> = movieApi.createPublisher(with: .getGenres)
        publisher.sink(
            receiveCompletion: {completion in
                guard case Subscribers.Completion<MovieApiError>.failure(MovieApiError.jsonDecodingError) = completion else{
                    XCTFail()
                    expectation.fulfill()
                    return
                }
                expectation.fulfill()
            },
            receiveValue: {_ in }
        ).store(in: &cancelableStore)
        waitForExpectations(timeout: testTimeout, handler: nil)
    }
    
    func testCreatePublisher_Error_netError() throws{
        let expectation = expectation(description: #function)
        let request = movieApi.createRequest(.getGenres)!
        stub(request.url!, errorCode: 401)
        
        let publisher :AnyPublisher<GenresResponse,MovieApiError> = movieApi.createPublisher(with: .getGenres)
        publisher.sink(
            receiveCompletion: {completion in
                guard case Subscribers.Completion<MovieApiError>.failure(MovieApiError.networkError) = completion else{
                    XCTFail()
                    expectation.fulfill()
                    return
                }
                expectation.fulfill()
            },
            receiveValue: {_ in }
        ).store(in: &cancelableStore)
        waitForExpectations(timeout: testTimeout, handler: nil)
    }
}
