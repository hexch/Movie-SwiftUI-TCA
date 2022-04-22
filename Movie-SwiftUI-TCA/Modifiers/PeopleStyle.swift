//
//  PeopleStyle.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/22.
//

import Foundation
import SwiftUI

struct PeopleStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .frame(width: 53, height: 80)
            .cornerRadius(26)
    }
}

extension View {
    func peopleStyle() -> some View {
        return ModifiedContent(content: self, modifier: PeopleStyle())
    }
}
