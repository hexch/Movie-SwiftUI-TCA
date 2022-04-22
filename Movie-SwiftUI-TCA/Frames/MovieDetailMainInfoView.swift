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
    let movieId: Int
    let backdropUrl: URL
    let releaseDate: String?
    let runtime: Int?
    let rating: Float?
    let voteCount: Int?
    let genres: [Genre]
    
    var body: some View {
        Section{
            KFImage(backdropUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .listRowInsets(EdgeInsets())
            MovieCoreInfo(
                date: releaseDate,
                runtime: runtime,
                voteAvg: rating,
                voteCount: voteCount,
                genres: genres
            )
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
                movieId: movie.id,
                backdropUrl: movie.backdropUrl,
                releaseDate: movie.release_date,
                runtime: movie.runtime,
                rating: movie.vote_average,
                voteCount: movie.vote_count,
                genres: movie.genres ?? []
            )
        }
    }
}

fileprivate struct MovieCoreInfo: View {
    let date:String?
    let runtime:Int?
    let voteAvg:Float?
    let voteCount:Int?
    let genres:[Genre]
    
    var body: some View {
        VStack(alignment:.leading,spacing:5){
            HStack{
                if let date = date{
                    Text(date.prefix(4))
                }else{
                    Text("-")
                }
                Text("|")
                if let runtime = runtime{
                    Text("\(runtime) minutes")
                }else{
                    Text("-")
                }
            }
            HStack(alignment:.center){
                Image(systemName: "star.fill")
                
                Text("\(voteAvg?.formatted() ?? "-") (\(voteCount?.formatted() ?? "-"))")
                
            }
            //            if !genres.isEmpty{
            ScrollView(.horizontal){
                HStack{
                    ForEach(genres,id: \.id){genre in
                        MovieGenreCapsule(genre: genre.name)
                    }
                }
            }.padding(.vertical)
            //                }
        }.font(.callout)
    }
}
