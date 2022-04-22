//
//  MovieDetailMainInfoView.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/22.
//

import SwiftUI
import Kingfisher
import MovieApiFramework

struct MovieDetailMainInfoView: View {
    let movie: Movie
    var movieId: Int{
        movie.id
    }
    var backdropUrl: URL{
        movie.backdropUrl
    }
    var releaseDate: String{
        movie.release_date ?? "-"
    }
    var runtime: String{
        if let runtime = movie.runtime{
            return "\(runtime) minutes"
        }else{
            return "-"
        }
    }
    var rating: String{
        movie.vote_average.formatted()
    }
    var voteCount: String{
        movie.vote_count.formatted()
    }
    var genres: [Genre]{
        movie.genres ?? []
    }
    
    var body: some View {
        Section{
            KFImage(backdropUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .listRowInsets(EdgeInsets())
            VStack(alignment:.leading,spacing:5){
                HStack{
                    Text(releaseDate)
                    Text("|")
                    Text(runtime)
                }
                HStack(alignment:.center){
                    Image(systemName: "star.fill")
                    
                    Text("\(rating) \(voteCount)")
                }
                if !genres.isEmpty{
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(genres,id: \.id){genre in
                                MovieGenreCapsule(genre: genre.name)
                            }
                        }
                    }.padding(.vertical)
                }
            }.font(.callout)
            HStack{
                Text("Reviews")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct MovieDetailMainInfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        let movie = Movie.sample
        return List{
            MovieDetailMainInfoView(
                movie: .sample
            )
        }
    }
}
