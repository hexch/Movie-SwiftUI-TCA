//
//  MovieDetailView.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import SwiftUI
import MovieApiFramework
import Kingfisher

struct MovieDetailView: View {
    let movie:Movie
    var body: some View {
        ScrollView{
            VStack{
                KFImage(movie.backdropUrl)
                    .resizable()
                    .frame(height:300)
                Text(movie.userTitle)
                    .font(.system(size: 24))
                
            }
        }.ignoresSafeArea()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .sample)
    }
}
