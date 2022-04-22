//
//  MovieGenreCapsule.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/22.
//

import SwiftUI

struct MovieGenreCapsule: View {
    let genre:String
    var body: some View {
        Text(genre)
            .padding(.horizontal,10)
            .padding(.vertical,3)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.clear)
                    .background(Color.orange)
                    .cornerRadius(10)
            )
    }
}

struct MovieGenreCapsule_Previews: PreviewProvider {
    static var previews: some View {
        MovieGenreCapsule(
            genre: "genre"
        )
    }
}
