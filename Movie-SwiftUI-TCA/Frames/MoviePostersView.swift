//
//  MoviePostersView.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import SwiftUI
import MovieApiFramework
import ComposableArchitecture

struct MoviePostersView: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(movies,id: \.id){movie in
                    NavigationLink(
                        destination: MovieDetail(
                            store: Store(
                                initialState: MovieDetailState(movie: movie),
                                reducer: movieDetailReducer,
                                environment: .live
                            )
                        )
                    ){
                        SimpleMoviePosterView(movie: movie)
                    }
                }
            }
        }
    }
}

struct MoviePostersView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePostersView(
            movies: [.sample,.sample,.sample,.sample,.sample,.sample]
        )
    }
}
