//
//  Movie.swift
//  MovieApiFramework
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation

public struct Movie: Codable, Identifiable, Hashable, MovieApiResponse {
    public let id: Int
    
    public let original_title: String
    public let title: String
    public var userTitle: String {
        //return AppUserDefaults.alwaysOriginalTitle ? original_title : title
        title
    }
    
    public let overview: String
    public let poster_path: String?
    public let backdrop_path: String?
    public let popularity: Float
    public let vote_average: Float
    public let vote_count: Int
    
    public let release_date: String?
    public var releaseDate: Date? {
        return release_date != nil ? Movie.dateFormatter.date(from: release_date!) : Date()
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd"
        return formatter
    }()
    
    public let genres: [Genre]?
    public let runtime: Int?
    public let status: String?
    public let video: Bool
    
    public var keywords: Keywords?
    public var images: MovieImages?
    
    public var production_countries: [productionCountry]?
    
    public var character: String?
    public var department: String?
    
    public struct Keywords: Codable, Hashable {
        public let keywords: [Keyword]?
    }
    
    public struct MovieImages: Codable, Hashable {
        public let posters: [ImageData]?
        public let backdrops: [ImageData]?
    }
    
    public struct productionCountry: Codable, Identifiable, Hashable {
        public var id: String {
            name
        }
        public let name: String
    }
}
public extension Movie{
    static let sample =  Movie(id: 0,
                               original_title: "Test movie Test movie Test movie Test movie Test movie Test movie Test movie ",
                               title: "Test movie Test movie Test movie Test movie Test movie Test movie Test movie  Test movie Test movie Test movie",
                               overview: "Test desc",
                               poster_path: "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
                               backdrop_path: "/5P8SmMzSNYikXpxil6BYzJ16611.jpg",
                               popularity: 50.5,
                               vote_average: 8.9,
                               vote_count: 1000,
                               release_date: "1972-03-14",
                               genres: [Genre(id: 0, name: "test")],
                               runtime: 80,
                               status: "released",
                               video: false)
    
}

