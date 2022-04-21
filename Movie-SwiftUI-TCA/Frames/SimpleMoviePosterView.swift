//
//  SimpleMoviePosterView.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import SwiftUI
import MovieApiFramework
import Kingfisher

struct SimpleMoviePosterView: View {
    let movie:Movie
    let base = "https://image.tmdb.org/t/p/w500/"
    var imageUrl :URL?{
        if let path = movie.poster_path{
            return URL(string: "\(base)\(path)")
        }else{
            return nil
        }
    }
    
    var body: some View {
        KFImage(imageUrl)
            .placeholder{
                SimpleMoviePosterPlaceHolderView()
            }
            .resizable()
            .renderingMode(.original)
            .posterStyle(loaded: true, size: .medium)
    }
}
struct SimpleMoviePosterPlaceHolderView: View{
    var body: some View{
        Rectangle()
            .foregroundColor(.gray)
            .posterStyle(loaded: false, size: .medium)
    }
}
struct SimpleMoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleMoviePosterView(movie: .sample)
    }
}
