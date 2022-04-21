//
//  MovieApiError.swift
//  MovieApiFramework
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//
import Foundation
public enum MovieApiError :Error{
    case noResponse
    case urlError
    case jsonDecodingError(error: Error)
    case networkError(error: Error)
}
