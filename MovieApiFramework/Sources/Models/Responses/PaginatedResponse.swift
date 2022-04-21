//
//  PaginatedResponse.swift
//  MovieApiFramework
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation
public struct PaginatedResponse<T: Codable&Equatable>: Codable, MovieApiResponse {
    public  let page: Int?
    public let total_results: Int?
    public let total_pages: Int?
    public let results: [T]
}
