//
//  MoviePostersView.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import SwiftUI
import MovieApiFramework

struct MoviePostersView: View {
    let movies: [Movie]
    let onTap: (Movie)->Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(movies,id: \.id){movie in
                    Button(action: {self.onTap(movie)}){
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
            movies: [.sample,.sample,.sample,.sample,.sample,.sample],
            onTap: {_ in
                
            })
    }
}
