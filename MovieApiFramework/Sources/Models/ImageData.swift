//
//  ImageData.swift
//  MovieApiFramework
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import Foundation
import SwiftUI

public struct ImageData: Codable, Identifiable, Hashable, Equatable {
    public var id: String {
        file_path
    }
    public let aspect_ratio: Float
    public let file_path: String
    public let height: Int
    public let width: Int
}
