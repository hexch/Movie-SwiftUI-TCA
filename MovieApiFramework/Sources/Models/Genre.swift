//
//  Genre.swift
//  MovieApiFramework
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation

public struct Genre: Codable, Identifiable, Hashable, Equatable {
    public let id: Int
    public let name: String
}
